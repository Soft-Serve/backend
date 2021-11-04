class DietaryInstancePresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      dietary_id: item.dietary_id,
      name: item.dietary.name,
      menu_item_id: item.menu_item_id
    }
  end
end

