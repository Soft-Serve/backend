class BannersController < ApplicationController
  before_action :fetch, only: %i[show update destroy]

  def index
    render json: (collection.filter.map { |banner| serialize(banner) })
  end

  def create
    result = BannerInteractor::Create.new(
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
    if @banner
      render json: serialize(@banner)
    else
      render 'Not found', status: :not_found
    end
  end

  def update
    result = BannerInteractor::Update.new(
      author: current_user,
      banner: @banner,
      params: strong_params
    ).call

    if result.successful?
      render json: serialize(result.unwrap!)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = BannerInteractor::Destroy.new(
      author: current_user,
      banner: @banner
    ).call

    if result.successful?
      render json: serialize(result.value)
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def serialize(banner)
    BannerPresenter.new(banner).serialize
  end

  def restaurant
    @restaurant = Restaurant.find_by(slug: params[:restaurant_id]) || Restaurant.find_by(id: params[:restaurant_id])
  end

  def collection
    BannersCollection.new(restaurant)
  end

  def fetch
    @banner = Banner.find_by(id: params[:id])
  end

  def strong_params
    params.permit(
      :header,
      :sub_header,
      :photo,
      :restaurant_id
    )
  end
end
