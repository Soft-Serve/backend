class DietariesCollection

  def initialize(restaurant, active)
    @restaurant = restaurant
    @active = active
  end

  def filter
    coll = scope_by_restaurant
    coll = scope_by_active(coll) if active
    coll
  end

  private

  attr_reader :restaurant, :active

  def scope_by_restaurant
    restaurant.dietaries
  end

  def scope_by_active(coll)
    coll.select { |dietary| dietary.dietary_instances.length > 0 }
  end
end
