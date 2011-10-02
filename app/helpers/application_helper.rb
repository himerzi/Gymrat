module ApplicationHelper
  def hasnt_voted?(wall)
    if current_user
      return (wall.voters.include?(current_user.id)) ? false : true
    end
  end
  def hasnt_climbed_this?(wall)
   # return true
    if current_user
     # debugger
        return (current_user.climbs.include?(wall) ? false : true)

    end
  end
end
