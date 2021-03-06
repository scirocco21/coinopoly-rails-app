class PortfoliosController < ApplicationController
  include UsersHelper

  def new
    @user = current_user
    @portfolio = Portfolio.new
  end

  def index
    @user = User.find_by(id: params[:user_id])
    @portfolios = @user.portfolios
    render json: @portfolios
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @portfolio = @user.portfolios.build(portfolio_params)
    @portfolio.save
    if @portfolio.errors.any?
      render :new
    else
      redirect_to user_portfolio_path(@user, @portfolio)
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @portfolio = Portfolio.find_by(id: params[:id])
    @position = Position.new
    @positions = @portfolio.positions
    @coins = Coin.all
    respond_to do |format|
      format.html
      format.json { render json: @portfolio, include: ['user', 'positions','positions.coin', 'positions.coin.name', 'positions.coin.img_url'] }
    end
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @portfolio = Portfolio.find(params[:id])
    @portfolio.update(portfolio_params)
    if @portfolio.errors.any?
      flash[:error] = "Something went wrong. Try again."
      render :new
    else
      redirect_to user_portfolio_path(@user, @portfolio)
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.portfolios.delete(Portfolio.find(params[:id]))
    redirect_to user_path(@user)
  end

  private
  def portfolio_params
    params.require(:portfolio).permit(:name, :public, :user_id)
  end
end
