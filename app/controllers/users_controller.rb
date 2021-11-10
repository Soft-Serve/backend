class UsersController < ApplicationController
  before_action :fetch, only: %i[update]

  def index
    render json: (collection.filter.map { |user| serialize(user) })
  end

  def update
    result = UserInteractor::Update.new(
      author: current_user,
      user: @user,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def find_current_user
    if current_user
      render json: UserPresenter.new(current_user).serialize
    else
      head :no_content
    end
  end

  private

  def collection
    ::UsersCollection.new(restaurant)
  end

  def fetch
    @user = User.find_by(id: params[:id])
  end

  def serialize(user)
    UserPresenter.new(user).serialize
  end

  def restaurant
    @restaurant = Restaurant.find_by(slug: params[:restaurant_id]) || Restaurant.find_by(id: params[:restaurant_id])
  end

  def strong_params
    params.permit(
      :restaurant_id,
      :first_name,
      :last_name,
      :role
    )
  end
end
