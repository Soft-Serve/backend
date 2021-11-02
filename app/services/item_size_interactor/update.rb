module ItemSizeInteractor
  class Update
    def initialize(author:, item_size:, params:)
      @author = author
      @item_size = item_size
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :item_size

    def body
      item_size.update!(params)

      ::Result::Ok.new(item_size)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
