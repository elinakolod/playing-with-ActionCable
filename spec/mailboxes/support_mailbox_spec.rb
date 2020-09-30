RSpec.describe SupportMailbox do
  let(:mail) { Mail.new(from: user_email, body: FFaker::Lorem.sentence) }
  let(:user_email) { user.email }

  it 'routes email to properly mailbox' do
    expect(SupportMailbox).to receive_inbound_email(to: 'support@chatter.org')
  end

  context 'user exists' do
    let(:user) { create(:user) }

    before do
      user
    end

    it 'marks email as delivered' do
      expect(process(mail)).to have_been_delivered
    end

    it 'sends autoreply' do
      process(mail)
      expect(Sidekiq::Worker.jobs.size).to eq(3)
    end
  end

  context 'user does not exist' do
    let(:user) { build(:user) }

    it 'marks email as delivered' do
      expect(process(mail)).to have_bounced
    end
  end
end
