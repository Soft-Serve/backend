module BannerInteractor
  class Update
    def initialize(author:, params:, banner:)
      @author = author
      @banner = banner
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :size_params, :params, :author, :banner

    def body
      banner.update!(params)

      ::Result::Ok.new(banner)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
