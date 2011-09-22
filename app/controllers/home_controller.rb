class HomeController < ApplicationController
  def index
    @climbing_centre = ClimbingCentre.find(params[:id])
    @walls = @climbing_centre.walls.order_by('pt', :des)
    @walls = @walls.paginate(:per_page => 15, :page  => params[:page])

    @climbers = User.all.order_by('climb_score', :desc)
    @climbers = @climbers.paginate(:per_page => 20, :page  => params[:page])
     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @climbing_centre }
     end
  end

end
