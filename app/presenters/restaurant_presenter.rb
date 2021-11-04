class RestaurantPresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def serialize
    {
      id: item.id,
      name: item.name,
      logo: item.logo,
      currency: item.currency,
      primary_colour: item.primary_colour,
      secondary_colour: item.secondary_colour,
      slug: item.slug,
      address_line_1: item.address_line_1,
      address_line_2: item.address_line_2,
      city: item.city,
      province: item.province,
      postal_code: item.postal_code,
      country: item.country
    }
  end
end
