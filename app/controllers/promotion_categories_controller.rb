class PromotionCategoriesController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |promotion_category| serialize(promotion_category) })
  end

  def create
    result = PromotionCategoryInteractor::Create.new(
      author: current_user,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!), status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    if @promotion_category
      render json: serialize(@promotion_category)
    else
      render json: { errors: "No item sizes with id" }, status: :unprocessable_entity
    end
  end

  def update
    result = PromotionCategoryInteractor::Update.new(
      author: current_user,
      promotion_category: @promotion_category,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = PromotionCategoryInteractor::Destroy.new(
      author: current_user,
      promotion_category: @promotion_category
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(promotion_category)
    PromotionCategoryPresenter.new(promotion_category).serialize
  end

  def promotion
    @promotion ||= Promotion.find_by(id: params[:promotion_id])
  end

  def collection
    PromotionCategoriesCollection.new(promotion)
  end

  def fetch
    @promotion_category = PromotionCategory.find_by(id: params[:id])
  end

  def strong_params
    params.permit(
      :discount,
      :unit,
      :promotion_id,
      :menu_category_id
    )
  end
end
