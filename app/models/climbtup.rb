class Climbtup
  include Mongoid::Fields::Serializable

  def deserialize(object)
    [ object[0], object[1] ]
  end

  def serialize(object)
    { "id" => object[0], "climbing_centre_id" => object[1] }
  end
end