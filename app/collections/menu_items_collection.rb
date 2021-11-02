class MenuItemsCollection

  def initialize(menu_category)
    @menu_category = menu_category
  end

  def filter
    coll = scope_by_menu_category
    coll
  end

  private

  attr_reader :menu_category

  def scope_by_menu_category
    menu_category.menu_items
  end
end
