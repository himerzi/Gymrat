class Climb
  include Mongoid::Document
  embedded_in :user
   field :wall_id
   field :climbing_centre_id
   validates_presence_of :wall_id, :climbing_centre_id
   
end