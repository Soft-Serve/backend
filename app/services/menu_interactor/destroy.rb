module MenuInteractor
  class Destroy
    def initialize(author:, menu:)
      @author = author
      @menu = menu
    end

    def call
      body
    end

    private

    attr_reader :author, :menu

    def body
      menu.destroy!

      ::Result::Ok.new(menu)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
