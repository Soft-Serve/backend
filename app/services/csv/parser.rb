require 'rubyXL'
require 'rubyXL/convenience_methods'

module Csv
  class Parser
    def initialize(file:, restaurant_id:)
      @file = file
      @restaurant_id = restaurant_id
    end

    def call
      create_menu_items!

      ::Result::Ok.new(Restaurant.find(restaurant_id))
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end

    def create_menu_items!
      worksheet.each_with_index do |row, index|
        next if row.cells.all? { |cell| cell.datatype.nil? }
        next if index == 0

        item = MenuItem.find_by(
          name: row[0]&.value,
          menu_category_id: menu_category(row).id
        )

        if item
          result = MenuItemInteractor::Update.new(
            author: User.first,
            menu_item: item,
            item_params: item_params(row),
            size_params: {
              sizes: sizes(row)
            }
          ).call
        else
          result = MenuItemInteractor::Create.new(
            author: User.first,
            item_params: item_params(row),
            size_params: {
              sizes: sizes(row)
            }
          ).call
        end

        create_allergies(result.value, row)
      end
    end

    def worksheet
      @worksheet ||= RubyXL::Parser.parse(file)['Menu Items']
    end

    def item_params(row)
      {
        name: row[0]&.value,
        description: row[1]&.value,
        menu_category_id: menu_category(row).id,
      }
    end

    def sizes(row)
      sizes_array = row.cells[5..-1]&.map{ |cell| cell&.value }&.each_slice(2).to_a.reject {|item| item[1].nil? }
      sizes_array&.map {|size| { unit: size[0], price: size[1] }}
    end

    def menu(row)
      Menu.find_or_create_by(name: row[2]&.value, restaurant_id: restaurant_id)
    end

    def menu_category(row)
      MenuCategory.find_or_create_by(name: row[3]&.value, menu_id: menu(row).id)
    end

    def create_allergies(item, row)
      return if row[4]&.datatype.nil?

      allergies_list = row[4].value.split(",")

      allergies_list.each do |allergy|
        dietary = Dietary.find_by(name: allergy, restaurant_id: restaurant_id)

        unless dietary
          dietary = DietaryInteractor::Create.new(
            author: User.first,
            params: {
              name: allergy,
              filter_name: "#{allergy} free",
              restaurant_id: restaurant_id
            }
          ).call.value
        end

        DietaryInstance.find_or_create_by(
          dietary_id: dietary.id,
          menu_item_id: item.id
        )
      end
    end

    private

    attr_reader :file, :restaurant_id
  end
end
