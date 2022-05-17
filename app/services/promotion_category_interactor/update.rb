module PromotionCategoryInteractor
  class Update
    def initialize(author:, promotion_category:, params:)
      @author = author
      @promotion_category = promotion_category
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :promotion_category

    def body
      promotion_category.update!(params)

      ::Result::Ok.new(promotion_category)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
