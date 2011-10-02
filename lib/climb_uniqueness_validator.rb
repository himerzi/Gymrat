class ClimbUniquenessValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return if object.climbs.nil?
      
      object.climbs.each do |climb|
     
        logger.debug "hello #{climb}"
        if climb['id'] == value['id']
          if climb.climbing_centre_id == value.climbing_centre_id
            object.errors[attribute] << (options[:message] || "User has allready climbed this climb")
            false
          end
        end
      end
      
  end
end 
