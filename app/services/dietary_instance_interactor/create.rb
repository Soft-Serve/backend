module DietaryInstanceInteractor
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

    def dietary
      @dietary ||= DietaryInstance.new(params)
    end

    def body
      dietary.save!

      ::Result::Ok.new(dietary)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
