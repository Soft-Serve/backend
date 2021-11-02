class ItemSizePresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      price: item.price,
      unit: item.unit,
      menu_item_id: item.menu_item_id
    }
  end
end
