class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
  def show
    @resource = resource_class.confirm_by_token(resource_params[:confirmation_token])

    redirect_header_options = { account_confirmation_success: true }

    if @resource.errors.empty?
      yield @resource if block_given?

      if signed_in?(resource_name)
        token = signed_in_resource.create_token
        signed_in_resource.save!

        redirect_headers = build_redirect_headers(token.token,
                                                  token.client,
                                                  redirect_header_options)

        redirect_to_link = signed_in_resource.build_auth_url(redirect_url, redirect_headers)
      else
        redirect_to_link = DeviseTokenAuth::Url.generate(redirect_url, { account_confirmation_success: true })
     end

      redirect_to(redirect_to_link)
    else
      if @resource.errors.details[:email][0][:error] == :already_confirmed
        redirect_to_link = DeviseTokenAuth::Url.generate(redirect_url, redirect_header_options)

        redirect_to(redirect_to_link)
      else
        raise ActionController::RoutingError, 'Not Found'
      end
    end
  end
end
