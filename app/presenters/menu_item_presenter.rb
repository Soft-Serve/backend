class MenuItemPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      name: item.name,
      description: item.description,
      menu_category_id: item.menu_category_id,
      available: item.available,
      photo: item.photo
    }
  end
end
