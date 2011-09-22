class Wall
  include Mongoid::Document
  #include Mongo::Voteable
  
  embedded_in :climbing_centre
  
  field :kind, type: String
  field :grade, type: String
  field :color, type: String
  field :number, type: Integer
  field :pt, type: Integer
  field :voters, type: Array
  FGrades = %w[5 5+ 6A 6A+ 6B 6B+ 6C 6C+ 7A 7A+ 7B 7B+ 8A 8A+ 8B 8B+ 9A 9A+]
  BGrades = %w[V0 V0+ V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 V14 15]
  Kinds = ['Boulder', 'Leading', 'Top Rope']
  validates :number, :presence => true
  validates :kind, :inclusion => Kinds, :presence  => true
  validates :grade, :inclusion => BGrades, :presence => true, :if => Proc.new { kind == 'Boulder' }
  validates :grade, :inclusion => FGrades, :presence => true, :unless => Proc.new { kind == 'Boulder' }

  # set points for each vote
  #voteable self, :up => +1, :down => -1, :index => true  
  #voteable
  def vote(direction, user_id)
    case direction
    when :up
      push(:voters, user_id)
      inc(:pt, 1)
    when :down
      points -= 1 
    else
      raise ArgumentError, 'Vote is not up or down'
    end
  end
     
end
