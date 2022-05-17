module PromotionInteractor
  class Create
    def initialize(author:, promotion_params:, category_params:)
      @author = author
      @promotion_params = promotion_params.to_h
      @category_params = category_params.to_h
    end

    def call
      body
    end

    private

    attr_reader :promotion_params, :category_params, :author

    def promotion
      @promotion ||= Promotion.new(promotion_params)
    end

    def body
      promotion.save!

      category_params[:categories].each do |params|
        PromotionCategoryInteractor::Create.new(
          author: author,
          params: params.merge(promotion_id: promotion.id)
        ).call
      end

      ::Result::Ok.new(promotion)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end

