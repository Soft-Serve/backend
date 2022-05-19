class PromotionPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      name: item.name,
      description: item.description,
      start_time: item.start_time,
      end_time: item.end_time,
      days: item.days.split(','),
      restaurant_id: item.restaurant_id
    }
  end
end
