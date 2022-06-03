class PromotionsCollection

  def initialize(restaurant)
    @restaurant = restaurant
  end

  def filter(active: false)
    coll = scope_by_restaurant
    coll = scope_by_active(coll) if active
    coll
  end

  private

  attr_reader :restaurant

  def scope_by_restaurant
    restaurant.promotions
  end

  def scope_by_active(coll)
    coll.select { |promotion| promotion.active? }
  end
end

