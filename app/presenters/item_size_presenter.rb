class ItemSizePresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      price: item.price,
      promo_prize: promo_price,
      unit: item.unit,
      menu_item_id: item.menu_item_id
    }
  end

  def promo_price
    nil
    # return nil unless promotion_category

    # if promotion_category.unit == 'percentage'
    #   item.price * promotion_category.amount
    # else
    #   item.price - promotion_category.amount
    # end
  end

  # def category 
  #   @category ||= item.menu_item.menu_category
  # end

  # def active_promotion
  #   @active_promotion ||= category.active_promotions.first
  # end

  # def promotion_category
  #   @promotion_category ||= PromotionCategory.find_by(promotion: active_promotion, category: category)
  # end
end
