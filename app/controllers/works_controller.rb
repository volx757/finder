class WorksController < ApplicationController


  def create
    @work = Work.new(params[:works])
    if @work.save
      flash[:notice] = "You created work successfully"
      flash[:color]= "valid"
      redirect_to :controller => 'home', :action => 'profile'
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render 'new'
    end
  end

end
