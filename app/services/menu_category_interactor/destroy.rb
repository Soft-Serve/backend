module MenuCategoryInteractor
  class Destroy
    def initialize(author:, menu_category:)
      @author = author
      @menu_category = menu_category
    end

    def call
      body
    end

    private

    attr_reader :author, :menu_category

    def body
      menu_category.destroy!

      ::Result::Ok.new(menu_category)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
