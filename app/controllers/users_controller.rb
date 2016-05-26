class UsersController < ApplicationController
	def home
		render :text => 'This is URL Shortener Application'
	end
  def new
  	@user = User.new
  end
  def show
  end
  def create
  	@user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      redirect_to "/sessions/new"
    else
      render :new
    end
   
  end																																	

  private
  	def user_params
  	  params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  	end
end
