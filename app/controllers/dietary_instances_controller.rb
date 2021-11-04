class DietaryInstancesController < ApplicationController
  before_action :fetch, only: %i[destroy]

  def index
    render json: (collection.filter.map { |dietary_instance| serialize(dietary_instance) })
  end

  def create
    result = DietaryInstanceInteractor::Create.new(
      author: current_user,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!), status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = DietaryInstanceInteractor::Destroy.new(
      author: current_user,
      dietary_instance: @dietary_instance
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(dietary_instance)
    DietaryInstancePresenter.new(dietary_instance).serialize
  end

  def menu_item
    @menu_item ||= MenuItem.find_by(id: params[:menu_item_id])
  end

  def collection
    DietaryInstancesCollection.new(menu_item)
  end

  def fetch
    @dietary_instance = DietaryInstance.find_by(id: params[:id])
  end

  def strong_params
    params.permit(
      :dietary_id,
      :menu_item_id
    )
  end
end
