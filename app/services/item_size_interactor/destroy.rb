module ItemSizeInteractor
  class Destroy
    def initialize(author:, item_size:)
      @author = author
      @item_size = item_size
    end

    def call
      body
    end

    private

    attr_reader :author, :item_size

    def body
      item_size.destroy!

      ::Result::Ok.new(item_size)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
