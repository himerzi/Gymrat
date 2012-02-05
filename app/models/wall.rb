class Wall
  include Mongoid::Document
  #include Mongo::Voteable
  
  embedded_in :climbing_centre
  has_and_belongs_to_many :users
  
  field :kind, type: String
  field :grade, type: String
  field :color, type: String
  field :number, type: Integer
  field :pt, type: Integer
  field :voters, type: Array
  FGrades = %w[5 5+ 6A 6A+ 6B 6B+ 6C 6C+ 7A 7A+ 7B 7B+ 8A 8A+ 8B 8B+ 9A 9A+]
  BGrades = %w[V0 V0+ V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 V14 V15]
  Kinds = ['Boulder', 'Leading', 'Top Rope']
  JSONFGrades = "[{\"label\":\"5\",\"value\":\"5\"},{\"label\":\"5+\",\"value\":\"5+\"},{\"label\":\"6A\",\"value\":\"6A\"},{\"label\":\"6A+\",\"value\":\"6A+\"},{\"label\":\"6B\",\"value\":\"6B\"},{\"label\":\"6B+\",\"value\":\"6B+\"},{\"label\":\"6C\",\"value\":\"6C\"},{\"label\":\"6C+\",\"value\":\"6C+\"},{\"label\":\"7A\",\"value\":\"7A\"},{\"label\":\"7A+\",\"value\":\"7A+\"},{\"label\":\"7B\",\"value\":\"7B\"},{\"label\":\"7B+\",\"value\":\"7B+\"},{\"label\":\"8A\",\"value\":\"8A\"},{\"label\":\"8A+\",\"value\":\"8A+\"},{\"label\":\"8B\",\"value\":\"8B\"},{\"label\":\"8B+\",\"value\":\"8B+\"},{\"label\":\"9A\",\"value\":\"9A\"},{\"label\":\"9A+\",\"value\":\"9A+\"}]"
  JSONBGrades = "[{\"label\":\"V0\",\"value\":\"V0\"},{\"label\":\"V0+\",\"value\":\"V0+\"},{\"label\":\"V1\",\"value\":\"V1\"},{\"label\":\"V2\",\"value\":\"V2\"},{\"label\":\"V3\",\"value\":\"V3\"},{\"label\":\"V4\",\"value\":\"V4\"},{\"label\":\"V5\",\"value\":\"V5\"},{\"label\":\"V6\",\"value\":\"V6\"},{\"label\":\"V7\",\"value\":\"V7\"},{\"label\":\"V8\",\"value\":\"V8\"},{\"label\":\"V9\",\"value\":\"V9\"},{\"label\":\"V10\",\"value\":\"V10\"},{\"label\":\"V11\",\"value\":\"V11\"},{\"label\":\"V12\",\"value\":\"V12\"},{\"label\":\"V13\",\"value\":\"V13\"},{\"label\":\"V14\",\"value\":\"V14\"},{\"label\":\"15\",\"value\":\"15\"}]"
  validates :number, :presence => true
  validates :kind, :inclusion => Kinds, :presence  => true
  validates :grade, :inclusion => BGrades, :presence => true, :if => Proc.new { kind == 'Boulder' }
  validates :grade, :inclusion => FGrades, :presence => true, :unless => Proc.new { kind == 'Boulder' }
  def self.json
    json = ""
    BGrades.each_with_index{|x,index| json <<'{"'+"label"+'":'+'"'+"#{x}"+'","value":'+"#{index}},"}
    json.chop!
    X.insert 0,"["
    X << "]"
    X
  end
  # set points for each vote
  #voteable self, :up => +1, :down => -1, :index => true  
  #voteable
  def vote(direction, user_id)
    if (voters)
      return false if voters.include? user_id
    end
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
