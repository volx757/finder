class HomeController < ApplicationController

  before_filter :authenticate_user, :except => [:index, :login, :logout]
  before_filter :save_login_state, :only => [:index, :login, :login]

  def index
    @page = 'index'
    @user = User.new
  end

  def settings
  end

  def search_results
    @works = []
    @users = []
    @users2 = []
    if params[:search]
      @works = Work.search(params[:search])
      @users = User.search(params[:search])
    else
      @users2 = User.where(:status => params[:status], :city => params[:city])
    end
  end

  def work_detail
    work = Work.find_by_id(params[:id])
    if work.present?
      @work = work
    else
      flash[:notice] = 'work not found'
      redirect_to(:action => 'profile')
    end
  end

  def login
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "you logged in as #{authorized_user.username}"
      redirect_to(:controller => 'users', :action => 'profile')
    else
      flash[:notice] = "Invalid Username or Password"
      @user = User.new
      render 'index'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'index'
  end

end
