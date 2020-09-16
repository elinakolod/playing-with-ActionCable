require 'rails_helper'

RSpec.describe PersonalMessagesController, type: :controller do
  describe "POST #create" do
    let(:personal_message_attrs) { attributes_for(:personal_message) }
    let(:sender) { create(:user) }
    let(:receiver) { create(:user) }
    let(:conversation) { create(:conversation, author_id: sender.id, receiver_id: receiver.id) }
    let(:params) { { personal_message: personal_message_attrs, receiver_id: receiver.id } }
    let(:send_message) { post :create, xhr: true, params: params }

    before do
      sender
      receiver
      controller.sign_in(sender)
      post :create, xhr: true
    end

    context 'new conversation' do
      let(:params) { { receiver_id: receiver.id, personal_message: personal_message_attrs } }

      it 'creates message' do
        expect { send_message }.to change{PersonalMessage.count}.by(1)
      end

      it 'creates conversation' do
        expect { send_message }.to change{Conversation.count}.by(1)
      end

      it 'broadcast massage to room channel' do
        expect { send_message }.to have_broadcasted_to("room_channel").with(body: personal_message_attrs[:body], sender: sender.name)
      end
    end

    context 'existing conversation' do
      let(:params) { { conversation_id: conversation.id, personal_message: personal_message_attrs } }

      before do
        conversation
      end

      it 'creates message' do
        expect { send_message }.to change{PersonalMessage.count}.by(1)
      end

      it 'does not creates conversation' do
        expect { send_message }.not_to change{Conversation.count}
      end

      it 'send notification to receiver' do
        expect { send_message }.to have_broadcasted_to("notifier_#{receiver.id}_channel").exactly(:once)
      end
    end
  end
end
