module MenuInteractor
  class Update
    def initialize(author:, menu:, params:)
      @author = author
      @menu = menu
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :menu

    def body
      menu.update!(params)

      ::Result::Ok.new(menu)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
