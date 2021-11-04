class ItemSizesController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |item_size| serialize(item_size) })
  end

  def create
    result = ItemSizeInteractor::Create.new(
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
    if @item_size
      render json: serialize(@item_size)
    else
      render 'Not found', status: :not_found
    end
  end

  def update
    result = ItemSizeInteractor::Update.new(
      author: current_user,
      item_size: @item_size,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = ItemSizeInteractor::Destroy.new(
      author: current_user,
      item_size: @item_size
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(item_size)
    ItemSizePresenter.new(item_size).serialize
  end

  def menu_item
    @menu_item ||= MenuItem.find_by(id: params[:menu_item_id])
  end

  def collection
    ItemSizesCollection.new(menu_item)
  end

  def fetch
    @item_size = ItemSize.find_by(id: params[:id])
  end

  def strong_params
    params.permit(
      :price,
      :unit,
      :menu_item_id
    )
  end
end
