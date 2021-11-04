module DietaryInteractor
  class Destroy
    def initialize(author:, dietary:)
      @author = author
      @dietary = dietary
    end

    def call
      body
    end

    private

    attr_reader :author, :dietary

    def body
      dietary.destroy!

      ::Result::Ok.new(dietary)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
