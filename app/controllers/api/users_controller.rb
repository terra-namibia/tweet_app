class Api::UsersController < ApplicationController
  before_action :validate_key, {only: [:all, :show]}
  before_action :set_user, only: :show
  
  # GET /api/users/all 整形しない
  def all
    @users = User.all
    render json: @users
  end

  # GET /api/users/:id 整形する
  def show
    #render json: @user
    render json: response_fields(@user)
  end

  private

  def validate_key
    unless api_keys('users').include?(params[:api_key])
      response_unauthorized
    end
  end

  def api_keys(key_type)
    @api_keys = YAML.load_file("#{Rails.root}/config/api_keys.yml")
    @api_keys[key_type]
  end

  def set_user
    @user = User.find_by(id: params[:id])
    response_not_found(:user) if @user.blank?
  end

  #整形
  def response_fields(user)
    response = user.as_json.except('created_at', 'updated_at', 'deleted_at')
    JSON.pretty_generate(response)
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name = 'page')
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

end
