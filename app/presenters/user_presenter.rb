class UserPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      first_name: item.first_name,
      last_name: item.last_name,
      role: item.role,
      email: item.email,
      restaurant_id: item.restaurant_id
    }
  end
end
