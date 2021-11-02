class MenuCategoriesController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |menu_category| serialize(menu_category) })
  end

  def create
    result = MenuCategoryInteractor::Create.new(
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
    if @menu_category
      render json: serialize(@menu_category)
    else
      render 'Not found', status: :not_found
    end
  end

  def update
    result = MenuCategoryInteractor::Update.new(
      author: current_user,
      menu_category: @menu_category,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = MenuCategoryInteractor::Destroy.new(
      author: current_user,
      menu_category: @menu_category
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(menu_category)
    MenuCategoryPresenter.new(menu_category).serialize
  end

  def menu
    @menu ||= Menu.find_by(id: params[:menu_id])
  end

  def collection
    MenuCategoriesCollection.new(menu)
  end

  def fetch
    @menu_category = MenuCategory.find_by(id: params[:id])
  end

  def strong_params
    params.permit(
      :name,
      :category_type,
      :menu_id
    )
  end
end
