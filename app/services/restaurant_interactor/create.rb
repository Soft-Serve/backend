module RestaurantInteractor
  class Create
    def initialize(params:)
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params

    def restaurant
      @restaurant ||= Restaurant.new(params)
    end

    def body
      restaurant.save!

      create_dietaries

      ::Result::Ok.new(restaurant)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end

    def create_dietaries
      Dietary::DIETARIES.map do |dietary_params|
        DietaryInteractor::Create.new(
          author: restaurant.users.first,
          params: dietary_params.merge!(restaurant_id: restaurant.id)
        ).call
      end
    end
  end
end
