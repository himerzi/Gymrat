class User
  #require 'climb_uniqueness_validator'
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  has_and_belongs_to_many :climbing_centres
  
  #**** Devise ****#
  
  ## Database authenticatable
   field :email,              :type => String, :null => false
   field :encrypted_password, :type => String, :null => false

   ## Recoverable
   field :reset_password_token,   :type => String
   field :reset_password_sent_at, :type => Time

   ## Rememberable
   field :remember_created_at, :type => Time

   ## Trackable
   field :sign_in_count,      :type => Integer
   field :current_sign_in_at, :type => Time
   field :last_sign_in_at,    :type => Time
   field :current_sign_in_ip, :type => String
   field :last_sign_in_ip,    :type => String

   ## Encryptable
   # field :password_salt, :type => String

   ## Confirmable
   # field :confirmation_token,   :type => String
   # field :confirmed_at,         :type => Time
   # field :confirmation_sent_at, :type => Time
   # field :unconfirmed_email,    :type => String # Only if using reconfirmable

   ## Lockable
   # field :failed_attempts, :type => Integer # Only if lock strategy is :failed_attempts
   # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
   # field :locked_at,       :type => Time

   # Token authenticatable
   # field :authentication_token, :type => String

  #**** old Devise 1.4.5 ****#
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
         
  #field :username
  field :first_name
  field :last_name
  field :admin, type: Boolean, default: true 
  field :climb_ids, type: Array, default: []
  field :climb_score, type: Integer, default: 0
  #validates :climbs, :climb_uniqueness => true
  #validates_uniqueness_of :climbs
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :admin, :climb_ids
  def climbs

    arry = []

    climb_ids.each do |c|
      arry << ClimbingCentre.find(c['climbing_centre_id']).walls.find(c['wall_id'])
    end
    arry
  end
  def climbed_it(wall)
    #return false unless try(:climb_ids?)
    if self.climbs.include?(wall)
      return false
    else
      #debugger
      add_to_set(:climb_ids, {:climbing_centre_id => wall.climbing_centre.id,:wall_id => wall.id})
      update_score(wall)
      #self.climb_ids << {:climbing_centre_id => wall.climbing_centre.id,:wall_id => wall.id}
    end
  end
 # def walls(wall)
 #    centre = self.climbing_centres.find_or_create(wall.climbing_centre)
 #    #map.find(self.location_id)
 # end
  
  def update_score(wall)
     #wall.kind == "Boulder" ?
    #{V0 => 1,:V0+ => 2,:V1 => 3,:V2 => 4,:V3 => 5,:V4 => 7,:V5  => 8}
    #: 
    score_table = {'5' => 1, '5+' => 2, '6A' => 3, '6A+' => 4, '6A+'  => 5, '6B' => 6,'6B+' => 6, '6C' => 7, '6C+' => 8, '7A' => 9, '7A+' => 10, '7B' => 11, '7B+' => 12}
    s = score_table[wall.grade]
    inc(:climb_score, s)
  end
  
  private
  def old_climbed_it(wall)
    
    def equal_climb(one,something)
      #something is in bson object id formate, one isnt
      
      one.wall_id == something.wall_id.to_s && one.climbing_centre_id == something.climbing_centre_id.to_s
    end
    def include? (climb1, a_climb)
      
      climb1.each do |clim|
       return true if equal_climb(clim, a_climb)
      end
      false
    end
    ##serialized_wall = {:id => wall.id, :climbing_centre_id => wall.climbing_centre.id}
    #before_size = try(:climbs?) ? climbs.size : 0,
    ##check size of climbs array before and after to see if we are attempting to add a repeated climb or not.
    ##debugger
    ##
    #debugger
    #push(:climbs, [wall.id,wall.climbing_centre.id]) #unless climbs.include?([wall.id, wall.climbing_centre.id])
    #if climbs.size > before_size
    #  debugger
    #  update_score(wall)
    #  return true
    #else
    #  return false
    #end
      if include?(climbs,Climb.new(:wall_id => wall.id,:climbing_centre_id =>  wall.climbing_centre.id))
        return false
      end
  #  p = Climb.new(:wall_id => wall.id,:climbing_centre_id =>  wall.climbing_centre.id)
  #  climbs.each do |climb|
  #   return false if climb == p
  #  end
     #person.addresses.create!(city,,: "Berlin")
     #p = 
       #update_score(wall) if climbs.create(wall_id: wall.id,climbing_centre_id: wall.climbing_centre.id) 
        p = Climb.new(:wall_id =>  wall.id, :climbing_centre_id =>  wall.climbing_centre.id)
        climbs.create!(wall_id: wall.id.to_s, climbing_centre_id: wall.climbing_centre.id.to_s)
        update_score(wall)
   #  end
   #end
  end
end
