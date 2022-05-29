module PromotionInteractor
  class Create
    def initialize(author:, promotion_params:)
      @author = author
      @promotion_params = promotion_params.to_h
    end

    def call
      body
    end

    private

    attr_reader :promotion_params, :category_params, :author

    def promotion
      promotion_params.update({ 
        start_time: format_time(promotion_params[:start_time]), 
        end_time: format_time(promotion_params[:end_time])
      })
      
      @promotion ||= Promotion.new(promotion_params)
    end

    def body
      promotion.save!

      ::Result::Ok.new(promotion)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end

    def format_time(time)
      return time unless time&.to_s&.match?(/\d{2}:\d{2}\z/)
  
      time_array = time.split(':') 
      Time.new(2022, 01, 01, time_array[0], time_array[1], 0)
    end
  end
end

