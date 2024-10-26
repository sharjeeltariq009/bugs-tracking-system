module BugsHelper
  def human_readable_status(bug)
    case bug.status
    when "not_started"
      "New"
    when "started"
      "Started"
    when "completed"
      "Completed"
    when "resolved"
      "Resolved"
    else
      "Unknown"
    end
  end
end
