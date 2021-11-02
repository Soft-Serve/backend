class MenuItemsController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |menu_item| serialize(menu_item) })
  end

  def create
    result = MenuItemInteractor::Create.new(
      author: current_user,
      item_params: item_params,
      size_params: size_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!), status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    if @menu_item
      render json: serialize(@menu_item)
    else
      render 'Not found', status: :not_found
    end
  end

  def update
    result = MenuItemInteractor::Update.new(
      author: current_user,
      menu_item: @menu_item,
      item_params: item_params,
      size_params: size_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = MenuItemInteractor::Destroy.new(
      author: current_user,
      menu_item: @menu_item
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(menu_item)
    MenuItemPresenter.new(menu_item).serialize
  end

  def menu_category
    @menu_category ||= MenuCategory.find_by(id: params[:menu_category_id])
  end

  def collection
    MenuItemsCollection.new(menu_category)
  end

  def fetch
    @menu_item = MenuItem.find_by(id: params[:id])
  end

  def item_params
    params.permit(
      :name,
      :description,
      :available,
      :menu_category_id,
      :photo
    )
  end

  def size_params
    params.permit(:sizes => [:unit, :price, :id])
  end
end
