class User
  include Mongoid::Document
  include Mongo::Voter
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  field :username
  field :climbs, type: Hash
  field :climb_score, type: Integer
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :case_sensitive => false
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  def climbed_it(wall)
    serialized_wall = {:id => wall.id,:climbing_centre_id => wall.climbing_centre.id}
    push(:climbs, serialized_wall)
    update_score(wall)
  end
  def update_score(wall)
     #wall.kind == "Boulder" ?
    #{V0 => 1,:V0+ => 2,:V1 => 3,:V2 => 4,:V3 => 5,:V4 => 7,:V5  => 8}
    #: 
    score_table = {'5' => 1, '5+' => 2, '6A' => 3, '6A+' => 4, '6A+'  => 5, '6B+' => 6, '6C' => 7, '6C+' => 8, '7A' => 9, '7A+' => 10, '7B' => 11, '7B+' => 12}
    s = score_table[wall.grade]
    inc(:climb_score, s)
  end
end
