require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }
  let(:env) { instance_double('env') }

  before do
    allow_any_instance_of(ApplicationCable::Connection).to receive(:env).and_return(env)
    allow(env).to receive(:[]).with('warden').and_return(warden)
  end

  context 'with a verified user' do
    let(:warden) { instance_double('warden', user: user) }

    it "successfully connects" do
      connect
      expect(connect.current_user.id).to eq(user.id)
    end

  end

  context 'without a verified user' do
    let(:warden) { instance_double('warden', user: nil) }

    it "rejects connection" do
      expect { connect }.to have_rejected_connection
    end
  end
end
