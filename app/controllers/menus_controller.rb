class MenusController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |menu| serialize(menu) })
  end

  def create
    result = MenuInteractor::Create.new(
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
    if @menu
      render json: serialize(@menu)
    else
      render json: { errors: "No menus with id" }, status: :unprocessable_entity
    end
  end

  def update
    result = MenuInteractor::Update.new(
      author: current_user,
      menu: @menu,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = MenuInteractor::Destroy.new(
      author: current_user,
      menu: @menu
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(menu)
    MenuPresenter.new(menu).serialize
  end

  def restaurant
    @restaurant = Restaurant.find_by(slug: params[:restaurant_id]) || Restaurant.find_by(id: params[:restaurant_id])
  end

  def collection
    ::MenusCollection.new(restaurant)
  end

  def fetch
    @menu = Menu.find_by(id: params[:id])
  end

  def strong_params
    params.permit(
      :name,
      :restaurant_id
    )
  end
end
