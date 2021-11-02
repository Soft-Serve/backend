module UserInteractor
  class Update
    def initialize(author:, user:, params:)
      @author = author
      @user = user
      @params = params.to_h
    end

    def call
      body
    end

    private

    attr_reader :params, :author, :user

    def body
      user.update!(params)

      ::Result::Ok.new(user)
    rescue StandardError => e
      Result::Error.new(errors: [e.message])
    end
  end
end
