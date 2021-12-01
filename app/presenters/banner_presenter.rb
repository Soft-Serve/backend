class BannerPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      header: item.header,
      sub_header: item.sub_header,
      photo: item.photo,
      restaurant_id: item.restaurant_id
    }
  end
end
