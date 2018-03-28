class StaticController < ApplicationController
  before_action :authorize_request, except: :show
  def show 
    json_response("Welcome to todos-api")
  end
end
