module PromotionInteractor
  class Update
    def initialize(author:, promotion_params:, category_params:, promotion:)
      @author = author
      @promotion = promotion
      @promotion_params = promotion_params.to_h
      @category_params = category_params.to_h
    end

    def call
      body
    end

    private

    attr_reader :category_params, :promotion_params, :author, :promotion

    def body
      promotion.update!(promotion_params)

      destroy_removed_promotion_categories

      update_promotion_categories

      ::Result::Ok.new(promotion)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end

    def destroy_removed_promotion_categories
      return if category_params.empty?

      removed_categories = promotion.promotion_categories.where.not(id: category_params[:categories].pluck(:id))

      removed_categories.map do |category|
        PromotionCategoryInteractor::Destroy.new(
          author: author,
          promotion_category: category
        ).call
      end
    end

    def update_promotion_categories
      return if category_params.empty?

      category_params[:categories].map do |category|
        if category[:id]
          PromotionCategoryInteractor::Update.new(
            author: author,
            promotion_category: PromotionCategory.find(category[:id]),
            params: { unit: category[:unit], discount: category[:discount] }
          ).call
        else
          PromotionCategoryInteractor::Create.new(
            author: author,
            params: { 
              unit: category[:unit], 
              discount: category[:discount], 
              menu_category_id: category[:menu_category_id] 
            }.merge(promotion_id: promotion.id)
          ).call
        end
      end
    end
  end
end
