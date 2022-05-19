class RestaurantsController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |restaurant| serialize(restaurant) })
  end

  def create
    result = RestaurantInteractor::Create.new(
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!), status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    if @restaurant
      render json: serialize(@restaurant)
    else
      render json: { errors: "No restaurants with id" }, status: :unprocessable_entity
    end
  end

  def update
    result = RestaurantInteractor::Update.new(
      author: current_user,
      restaurant: @restaurant,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = RestaurantInteractor::Destroy.new(
      author: current_user,
      restaurant: @restaurant
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(restaurant)
    RestaurantPresenter.new(restaurant).serialize
  end

  def fetch
    @restaurant = Restaurant.find_by(slug: params[:id]) || Restaurant.find_by(id: params[:id])
  end

  def collection
    Restaurant.all
  end

  def strong_params
    params.permit(
      :name,
      :colour,
      :tint,
      :currency,
      :logo,
      :slug,
      :restaurant_slug,
      :address_line_1,
      :address_line_2,
      :city,
      :province,
      :postal_code,
      :country,
      :onboarding_done,
      :font
    )
  end
end
