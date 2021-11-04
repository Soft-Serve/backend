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
      menu_id: item.menu_id
    }
  end
end
