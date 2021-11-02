class MenuPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      name: item.name,
      restaurant_id: item.restaurant_id
    }
  end
end
