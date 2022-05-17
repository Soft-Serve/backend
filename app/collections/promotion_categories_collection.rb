class PromotionCategoriesCollection

  def initialize(promotion)
    @promotion = promotion
  end

  def filter
    coll = scope_by_promotion
    coll
  end

  private

  attr_reader :promotion

  def scope_by_promotion
    promotion.promotion_categories
  end
end

