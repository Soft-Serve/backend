class ItemSizePresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      price: item.price,
      promo_price: promo_price,
      unit: item.unit,
      menu_item_id: item.menu_item_id
    }
  end
    
  def promo_price
    return nil unless promotion_category && promotion&.active?

    if promotion_category.unit == 'percentage'
      item.price - (item.price * (promotion_category.discount / 100.00))
    else
      item.price - promotion_category.discount
    end
  end

  def category 
    @category ||= item.menu_item.menu_category
  end

  def promotion
    @promotion ||= promotion_category&.promotion
  end

  def promotion_category
    @promotion_category ||= category.promotion_categories&.first
  end
end
