class MenusCollection

  def initialize(restaurant)
    @restaurant = restaurant
  end

  def filter
    coll = scope_by_restaurant
    coll
  end

  private

  attr_reader :restaurant

  def scope_by_restaurant
    restaurant.menus
  end
end

