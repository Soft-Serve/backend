class PromotionsController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |promotion| serialize(promotion) })
  end

  def create
    result = PromotionInteractor::Create.new(
      author: current_user,
      promotion_params: promotion_params,
      category_params: category_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!), status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    if @promotion
      render json: serialize(@promotion)
    else
      render json: { errors: "No promotion with id" }, status: :unprocessable_entity
    end
  end

  def update
    result = PromotionInteractor::Update.new(
      author: current_user,
      promotion: @promotion,
      promotion_params: promotion_params,
      category_params: category_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = PromotionInteractor::Destroy.new(
      author: current_user,
      promotion: @promotion
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(promotion)
    PromotionPresenter.new(promotion).serialize
  end

  def fetch
    @promotion = Promotion.find_by(id: params[:id])
  end

  def restaurant
    @restaurant = Restaurant.find_by(slug: params[:restaurant_id]) || Restaurant.find_by(id: params[:restaurant_id])
  end

  def collection
    ::PromotionsCollection.new(restaurant)
  end

  def promotion_params
    params.permit(
      :name,
      :description,
      :days,
      :start_time,
      :end_time,
      :restaurant_id
    )
  end

  def category_params
    params.permit(:categories => [:menu_category_id, :discount, :unit, :id])
  end
end
