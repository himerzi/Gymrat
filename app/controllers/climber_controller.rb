class ClimberController < ApplicationController
  def index
    @climbers = User.all.order_by('climb_score', :desc)
    @climbers = @climbers.paginate(:per_page => 20, :page  => params[:page])
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
