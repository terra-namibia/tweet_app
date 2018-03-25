class Api::UsersController < ApplicationController
  protect_from_forgery :except => ["create"]  
  before_action :validate_key, {only: [:all, :show, :create]}
  before_action :set_user, only: :show
  
  # GET /api/users/all 整形なし
  def all
    @users = User.all
    render json: @users
  end

  # GET /api/users/:id 整形あり
  def show
    #render json: @user
    render json: response_fields(@user)
  end

  # POST /api/users/create
  def create
    @user = User.new(user_params)
    if @user.save
      response_success(:user, :create)
    else
      response_internal_server_error(@user)
    end
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

  #show 整形
  def response_fields(user)
    response = user.as_json.except('created_at', 'updated_at', 'deleted_at')
    JSON.pretty_generate(response)
  end

  #create params
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end


  # return status
  
  # 200 Success
  def response_success(class_name, action_name)
    render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}" }
  end

  # 400 Bad Request
  def response_bad_request
    render status: 400, json: { status: 400, message: 'Bad Request' }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(class_name = 'page')
    render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error(obj)
    render status: 500, json: { status: 500, messages: obj.errors.full_messages }
  end


end
