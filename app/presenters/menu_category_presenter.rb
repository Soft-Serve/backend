class MenuCategoryPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      name: item.name,
      category_type: item.category_type,
      menu_id: item.menu_id,
      has_active_promo: item.promotion_categories.select{ |promo_cat| promo_cat.promotion.active? }.any?
    }
  end
end
