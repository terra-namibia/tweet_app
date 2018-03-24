class Api::ApiController < ApplicationController

  def users
    @users = User.all
    render json: @users
  end


end
