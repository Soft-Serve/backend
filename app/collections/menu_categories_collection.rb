class MenuCategoriesCollection

  def initialize(menu)
    @menu = menu
  end

  def filter
    coll = scope_by_menu
    coll
  end

  private

  attr_reader :menu

  def scope_by_menu
    menu.menu_categories
  end
end
