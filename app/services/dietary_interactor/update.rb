module DietaryInteractor
  class Update
    def initialize(author:, dietary:, params:)
      @author = author
      @dietary = dietary
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :dietary

    def body
      dietary.update!(params)

      ::Result::Ok.new(dietary)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
