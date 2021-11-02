module MenuCategoryInteractor
  class Update
    def initialize(author:, menu_category:, params:)
      @author = author
      @menu_category = menu_category
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :menu_category

    def body
      menu_category.update!(params)

      ::Result::Ok.new(menu_category)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
