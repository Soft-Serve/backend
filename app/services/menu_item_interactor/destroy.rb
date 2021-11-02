module MenuItemInteractor
  class Destroy
    def initialize(author:, menu_item:)
      @author = author
      @menu_item = menu_item
    end

    def call
      body
    end

    private

    attr_reader :author, :menu_item

    def body
      menu_item.destroy!

      ::Result::Ok.new(menu_item)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
