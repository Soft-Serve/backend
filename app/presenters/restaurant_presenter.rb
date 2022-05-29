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
      colour: item.colour,
      tint: item.tint,
      background_colour: item.background_colour,
      background_tint: item.background_tint,
      font: item.font,
      slug: item.slug,
      address_line_1: item.address_line_1,
      address_line_2: item.address_line_2,
      city: item.city,
      province: item.province,
      postal_code: item.postal_code,
      country: item.country,
      has_items: item.menu_items.length > 0,
      has_styles: item.banners.length > 0 || item.colour != 'red' || item.tint != 400 || item.logo,
      onboarding_done: item.onboarding_done
    }
  end
end
