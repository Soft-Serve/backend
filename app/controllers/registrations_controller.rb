class RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :find_restaurant, only: :create
  def build_resource
    @resource            = resource_class.new(user_params)
    @resource.provider   = provider
    @resource.restaurant = restaurant

    # honor devise configuration for case_insensitive_keys
    if resource_class.case_insensitive_keys.include?(:email)
      @resource.email = sign_up_params[:email].try(:downcase)
    else
      @resource.email = sign_up_params[:email]
    end
  end

  private
#test
  def find_restaurant
    @current_restaurant ||= current_user&.restaurant || nil
  end

  def restaurant
    @current_restaurant || Restaurant.create!(restaurant_params)
  end

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name
    )
  end

  def restaurant_params
    params.permit(
      :name,
      :slug
    )
  end
end
