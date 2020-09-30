module Support
  class ExtractEmailContent
    def initialize(mail:)
      @mail = mail
    end

    def call
      message_params
    end

    private

    attr_reader :mail

    def message_params
      @message_params ||= { subject: mail.subject, text: fetch_content }
    end

    def fetch_content
      mail.parts[0]&.body&.decoded || mail.body.decoded
    end
  end
end
