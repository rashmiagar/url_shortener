class SessionsController < ApplicationController
  def new
    
  end
  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
    if @user && User.authenticate(@user.email, params[:session][:password])
      log_in @user
      redirect_to @user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  def destroy
  	log_out if user_signed_in?
  	redirect_to sessions_new_url
  end
end
