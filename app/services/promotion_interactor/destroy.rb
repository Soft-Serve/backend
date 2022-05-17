module PromotionInteractor
  class Destroy
    def initialize(author:, promotion:)
      @author = author
      @promotion = promotion
    end

    def call
      body
    end

    private

    attr_reader :author, :promotion

    def body
      promotion.destroy!

      ::Result::Ok.new(promotion)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
