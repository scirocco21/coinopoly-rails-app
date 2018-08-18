module ActivitiesHelper
  def displayable?(activity)
    if activity.trackable
      true unless activity.trackable_type == "Portfolio" && !activity.trackable.public || activity.trackable_type == "Position" && !activity.trackable.portfolio.public
    end
  end

end
