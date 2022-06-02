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
      start_time: item.start_time.strftime("%I:%M %p"),
      end_time: item.end_time.strftime("%I:%M %p"),
      days: item.days,
      restaurant_id: item.restaurant_id
    }
  end
end
