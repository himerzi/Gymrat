class WallsController < ApplicationController
  # GET /walls
  # GET /walls.json
  def index
    centre_id = params[:climbing_centre_id]
    @walls = ClimbingCentre.find(centre_id).walls.page(params[:page]).per(3)
    @centre = ClimbingCentre.find(centre_id).name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @walls }
    end
  end

  # GET /walls/1
  # GET /walls/1.json
  def show
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wall }
    end
  end

  # GET /walls/new
  # GET /walls/new.json
  def new
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wall }
    end
  end

  # GET /walls/1/edit
  def edit
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])
  end

  # POST /walls
  # POST /walls.json
  def create
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.create!(params[:wall])

    respond_to do |format|
      if @wall.save
        format.html { redirect_to climbing_centre_path(@centre), notice: 'Wall was successfully created.' }
        format.json { render json: @wall, status: :created, location: @wall }
      else
        format.html { render action: "new" }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /walls/1
  # PUT /walls/1.json
  def update
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])

    respond_to do |format|
      if @wall.update_attributes(params[:wall])
        format.html { redirect_to climbing_centre_wall_path(@centre, @wall), notice: 'Wall was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /walls/1
  # DELETE /walls/1.json
  def destroy
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])
    @wall.destroy

    respond_to do |format|
      format.html { redirect_to climbing_centre_path(@centre) }
      format.json { head :ok }
    end
  end
  def climbed_it
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])
    if current_user
      current_user.climbed_it(@wall)
      redirect_to climbing_centre_path(@centre), :notice => "Added to your tick-list !"
    else
      redirect_to climbing_centre_path(@centre), :notice => "You must be logged in to do this !"
    end
  end
  def vote_up
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])
    if current_user
      @wall.vote(:up, current_user.id)
      redirect_to climbing_centre_path(@centre), :notice => "Thanks for voting !"
    else
      redirect_to climbing_centre_path(@centre), :notice => "You must be logged in to vote !"
    end
  end
  
end
