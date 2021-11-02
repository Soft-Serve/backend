module RestaurantInteractor
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

    def restaurant
      @restaurant ||= Restaurant.new(params)
    end

    def body
      restaurant.save!

      ::Result::Ok.new(restaurant)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
