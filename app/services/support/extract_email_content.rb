module Support
  class ExtractEmailContent
    def initialize(mail:)
      @mail = mail
    end

    def call
      message
    end

    private

    attr_reader :mail

    def message
      @message ||= OpenStruct.new(title: mail.subject, text: fetch_content)
    end

    def fetch_content
      mail.parts.present? ? mail.parts[0].body.decoded : mail.decoded
    end
  end
end
