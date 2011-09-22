class ClimbingCentre
  include Mongoid::Document
  #include Mongo::Voteable
  field :name, type: String
  field :city, type: String
  validates :name, :city, :presence => true, :uniqueness => true, :length =>{:maximum=>250}
  embeds_many :walls
end
