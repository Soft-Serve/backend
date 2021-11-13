module BannerInteractor
  class Create
    def initialize(author:, params:)
      @author = author
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author

    def banner
      @banner ||= Banner.new(params)
    end

    def body
      banner.save!

      ::Result::Ok.new(banner)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end

