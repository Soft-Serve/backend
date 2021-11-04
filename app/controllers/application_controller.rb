class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery unless: -> { request.format.json? }

  def find_current_user
    return nil unless current_user

    render json: UserPresenter.new(current_user).serialize
  end
end
