module MenuItemInteractor
  class Create
    def initialize(author:, item_params:, size_params:)
      @author = author
      @item_params = item_params.to_h
      @size_params = size_params.to_h
    end

    def call
      body
    end

    private

    attr_reader :item_params, :size_params, :author

    def menu_item
      @menu_item ||= MenuItem.new(item_params)
    end

    def body
      menu_item.save!

      size_params[:sizes].each do |params|
        ItemSizeInteractor::Create.new(
          author: author,
          params: params.merge(menu_item_id: menu_item.id)
        ).call
      end


      ::Result::Ok.new(menu_item)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end

