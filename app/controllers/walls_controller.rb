class WallsController < ApplicationController
  before_filter :only_if_admin, :except => [:index, :show, :new,:climbed_it,:vote_up]
  before_filter :current_user? , :only => [:climbed_it,:vote_up]
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
    redirect_to root_url, :notice => current_user.climbed_it(@wall) ? "Added to your tick-list !" : "Allready on your tick-list"
  end
  def vote_up
    @centre = ClimbingCentre.find(params[:climbing_centre_id])
    @wall = @centre.walls.find(params[:id])
    @wall.vote(:up, current_user.id)
    redirect_to root_url, :notice => "Thanks for voting !"
  end
  
  def grades_by_kind
    
    if params[:id].present?
      
      @grades = (params[:id] == "Boulder" ? Wall::BGrades : Wall::FGrades)

    else
      @grades = []
    end

    respond_to do |format|
      format.js
    end
  end
  def get_drop_down_options
   
    if params[:selected].present?
      #[{"label":"Option 1","value":1},{"label":"Option 2","value":2}]
      @grades = (params[:selected] == "Boulder" ? Wall::JSONBGrades : Wall::JSONFGrades)
    else
      @grades = '[]'
    end
    #Use val to find records
    #options = @grades.collect{|x| "'#{x.id}' : '#{x.label}'"}    
    #render :text => "{#{options.join(",")}}" 
    render :text => @grades 

  end
  
end
