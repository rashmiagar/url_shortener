class Api::BaseController < ApplicationController
  skip_before_filter :verify_autheticity_token

  protected
    def current_user
      return @current_user if @current_user.present?
      
      if params[:api_token].present?
        return @current_user = User.find_by_api_token(params[:api_token])
      else
        return nil
      end
    end
    
    def authenticate_user!
      return true if current_user.present?
      
      render :json => "Access denied".to_json
      return false
    end
end