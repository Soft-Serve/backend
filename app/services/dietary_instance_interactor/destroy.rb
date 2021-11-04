module DietaryInstanceInteractor
  class Destroy
    def initialize(author:, dietary_instance:)
      @author = author
      @dietary_instance = dietary_instance
    end

    def call
      body
    end

    private

    attr_reader :author, :dietary_instance

    def body
      dietary_instance.destroy!

      ::Result::Ok.new(dietary_instance)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
