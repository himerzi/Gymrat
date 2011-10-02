class ClimbingCentresController < ApplicationController
  before_filter :only_if_admin, :except => [:index, :show]
  # GET /climbing_centres
  # GET /climbing_centres.json
  def index
    @climbing_centres = ClimbingCentre.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @climbing_centres }
    end
  end

  # GET /climbing_centres/1
  # GET /climbing_centres/1.json
  def show
    @climbing_centre = ClimbingCentre.find(params[:id])
    # kaminarri @walls = @climbing_centre.walls.page(params[:page]).per(3)
   @walls = @climbing_centre.walls.order_by('pt', :des)
   
   @walls = @walls.paginate(:per_page => 15, :page  => params[:page])
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @climbing_centre }
    end
  end

  # GET /climbing_centres/new
  # GET /climbing_centres/new.json
  def new
    
    @climbing_centre = ClimbingCentre.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @climbing_centre }
    end
  end

  # GET /climbing_centres/1/edit
  def edit
    @climbing_centre = ClimbingCentre.find(params[:id])
  end

  # POST /climbing_centres
  # POST /climbing_centres.json
  def create
    @climbing_centre = ClimbingCentre.new(params[:climbing_centre])

    respond_to do |format|
      if @climbing_centre.save
        format.html { redirect_to @climbing_centre, notice: 'Climbing centre was successfully created.' }
        format.json { render json: @climbing_centre, status: :created, location: @climbing_centre }
      else
        format.html { render action: "new" }
        format.json { render json: @climbing_centre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /climbing_centres/1
  # PUT /climbing_centres/1.json
  def update
    @climbing_centre = ClimbingCentre.find(params[:id])

    respond_to do |format|
      if @climbing_centre.update_attributes(params[:climbing_centre])
        format.html { redirect_to @climbing_centre, notice: 'Climbing centre was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @climbing_centre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /climbing_centres/1
  # DELETE /climbing_centres/1.json
  def destroy
    @climbing_centre = ClimbingCentre.find(params[:id])
    @climbing_centre.destroy

    respond_to do |format|
      format.html { redirect_to climbing_centres_url }
      format.json { head :ok }
    end
  end
end
