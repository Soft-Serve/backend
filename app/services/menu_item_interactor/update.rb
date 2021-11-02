module MenuItemInteractor
  class Update
    def initialize(author:, item_params:, size_params:, menu_item:)
      @author = author
      @menu_item = menu_item
      @item_params = item_params.to_h
      @size_params = size_params.to_h
    end

    def call
      body
    end

    private

    attr_reader :size_params, :item_params, :author, :menu_item

    def body
      menu_item.update!(item_params)

      destroy_removed_item_sizes

      update_item_sizes

      ::Result::Ok.new(menu_item)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end

    def destroy_removed_item_sizes
      return if size_params.empty?

      removed_sizes = menu_item.item_sizes.where.not(id: size_params[:sizes].pluck(:id))

      removed_sizes.map do |size|
        ItemSizeInteractor::Destroy.new(
          author: author,
          item_size: size
        ).call
      end
    end

    def update_item_sizes
      return if size_params.empty?

      size_params[:sizes].map do |size|
        if size[:id]
          ItemSizeInteractor::Update.new(
            author: author,
            item_size: ItemSize.find(size[:id]),
            params: { unit: size[:unit], price: size[:price] }
          ).call
        else
          ItemSizeInteractor::Create.new(
            author: author,
            params: { unit: size[:unit], price: size[:price] }.merge(menu_item_id: menu_item.id)
          ).call
        end
      end
    end
  end
end
