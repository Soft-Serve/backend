module BannerInteractor
  class Destroy
    def initialize(author:, banner:)
      @author = author
      @banner = banner
    end

    def call
      body
    end

    private

    attr_reader :author, :banner

    def body
      banner.destroy!

      ::Result::Ok.new(banner)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
