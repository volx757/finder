class UsersController < ApplicationController

  before_filter :authenticate_user, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:users])
    p params
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"

      authorized_user = User.authenticate(params[:users][:username], params[:users][:password])
      session[:user_id] = authorized_user.id

      redirect_to :controller => 'home', :action => 'profile'
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render 'new'
    end
  end

  def profile
    @work = Work.new
  end

  def update
    cleaned_params = params[:users].delete_if { |k, v| v.empty? }
    @current_user.update_attributes(cleaned_params)
    if @current_user.save
      flash[:notice] = "You updated successfully"
      flash[:color]= "valid"
      redirect_to :controller => 'home', :action => 'profile'
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render 'home/settings'
    end
  end

end
