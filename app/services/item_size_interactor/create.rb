module ItemSizeInteractor
  class Create
    def initialize(author:, params:)
      @author = author
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author

    def item_size
      @item_size ||= ItemSize.new(params)
    end

    def body
      item_size.save!

      ::Result::Ok.new(item_size)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
