module RestaurantInteractor
  class Update
    def initialize(author:, restaurant:, params:)
      @author = author
      @restaurant = restaurant
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :restaurant

    def body
      restaurant.update!(params)

      ::Result::Ok.new(restaurant)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
