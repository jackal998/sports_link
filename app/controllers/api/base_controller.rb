class Api::BaseController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :enable_cors, :client_auth, :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    if params[:auth_token].present?
      user = User.find_by_authentication_token( params[:auth_token] )
      # Devise: 設定 current_user
      sign_in(user, store: false) if user
    elsif controller_name == "users" && action_name == "show"
      user = User.find_by_authentication_token( params[:id] )
      # Devise: 設定 current_user
      sign_in(user, store: false) if user
    end
  end

  def enable_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST' #CRUD
    response.headers['Access-Control-Request-Methods'] = 'POST' #CRUD（基本沒差，可能是clien端名稱問題）
  end

  def client_auth
    unless request.headers["HTTP_SL_TTOOKKEENN"] == 'token'
      render json: { errors: 'Oops! something is broken, We\'ll soon fix it!'}, :status => 400
    end
  end
end
