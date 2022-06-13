class PromotionCategoryPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      discount: item.discount,
      unit: item.unit,
      promotion_id: item.promotion_id,
      menu_category_id: item.menu_category_id,
      menu_category_name: item.menu_category.name,
      menu_name: item.menu_category.menu.name
    }
  end
end
