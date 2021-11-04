class SessionsController < DeviseTokenAuth::SessionsController
  private

  def render_create_success
    render json: resource_data(resource_json: @resource.token_validation_response)
      .merge!(
        {
          "client" => @token.client,
          "access_token" => @token.token,
          "restaurant_slug" => @resource.restaurant.slug
        }
      )
  end
end
