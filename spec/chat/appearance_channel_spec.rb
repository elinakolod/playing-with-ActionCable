require 'rails_helper'

RSpec.describe AppearanceChannel, type: :channel do
  let(:user) { create(:user) }
  let(:redis_key) { "user_#{user.id}_online" }

  before do
    user
    stub_connection(current_user: user)
  end

  describe '#subscribed' do
    it "shows user is online" do
      expect { subscribe }.to have_broadcasted_to("appearances_channel").with(user_id: user.id, online: true)
    end

    it "subscribes user" do
      expect_any_instance_of(Redis).to receive(:set).with(redis_key, '1')
      expect_any_instance_of(Redis).not_to receive(:del)
      subscribe
      expect(subscription).to be_confirmed
    end
  end

  describe '#unsubscribed' do
    it "unsubscribes user" do
      expect_any_instance_of(Redis).to receive(:del).with(redis_key)
      subscribe
      subscription.unsubscribe_from_channel
    end

    it "shows user is offline" do
      subscribe
      expect { subscription.unsubscribe_from_channel }.to have_broadcasted_to("appearances_channel")
                                                      .with(user_id: user.id, online: false)
    end
  end
end
