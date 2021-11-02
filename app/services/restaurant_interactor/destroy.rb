module RestaurantInteractor
  class Destroy
    def initialize(author:, restaurant:)
      @author = author
      @restaurant = restaurant
    end

    def call
      body
    end

    private

    attr_reader :author, :restaurant

    def body
      restaurant.destroy!

      ::Result::Ok.new(restaurant)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
