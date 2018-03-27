class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  api :POST, '/auth/login', "User login"
  param :email, String, :desc => "Email of the user", required: true
  param :password, String, :desc => "Password of the user", required: true
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  api :POST, '/auth/logout', "User logout"
  def logout
    auth_token = nil
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
