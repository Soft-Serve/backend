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
      @promotion ||= Promotion.new({
        name: promotion_params[:name],
        description: promotion_params[:description],
        days: promotion_params[:days],
        start_time: format_time(promotion_params[:start_time]),
        end_time: format_time(promotion_params[:end_time]),
        restaurant_id: promotion_params[:restaurant_id]
      })
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

    def format_time(time)
      time_array = time.split(':')
      Time.new(2022, 01, 01, time_array[0], time_array[1], 0)
    end
  end
end

