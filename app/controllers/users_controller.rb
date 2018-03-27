class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  api :POST, '/signup', "Creates a new user"
  param :user_params, Hash, :desc => "Param description" do
    param :name, String, :desc => "Name of the user", :required => true
    param :email, String, :desc => "Email of the user", :required => true
    param :password, String, :desc => "Password of the user", :required => true
    param :password_confirmation, String, :desc => "Confirmation of password", :required => true
  end
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

end
