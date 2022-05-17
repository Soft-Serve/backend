module PromotionCategoryInteractor
  class Destroy
    def initialize(author:, promotion_category:)
      @author = author
      @promotion_category = promotion_category
    end

    def call
      body
    end

    private

    attr_reader :author, :promotion_category

    def body
      promotion_category.destroy!

      ::Result::Ok.new(promotion_category)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
