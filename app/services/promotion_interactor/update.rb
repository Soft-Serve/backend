module PromotionInteractor
  class Update
    def initialize(author:, promotion_params:, promotion:)
      @author = author
      @promotion = promotion
      @promotion_params = promotion_params.to_h
    end

    def call
      body
    end

    private

    attr_reader :category_params, :promotion_params, :author, :promotion

    def body
      promotion_params.update({ 
        start_time: format_time(promotion_params[:start_time]), 
        end_time: format_time(promotion_params[:end_time])
      })

      promotion.update!(promotion_params)

      ::Result::Ok.new(promotion)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end

    def format_time(time)
      return time unless time&.to_s&.match?(/\d{2}:\d{2}\z/)
      
      time_array = time.split(':')
      
      Time.new(2022, 01, 01, time_array[0], time_array[1], 00, '-05:00')
    end
  end
end
