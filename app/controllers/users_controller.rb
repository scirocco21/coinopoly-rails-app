class UsersController < ApplicationController

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to root_path
      end
    end


  def show
    @user = User.find(params[:id])
    if logged_in?
      render 'show'
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

end
