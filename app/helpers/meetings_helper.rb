module MeetingsHelper
  def sti_meeting_path(type = "meeting", meeting = nil, action = nil)
    send "#{format_sti(action, type, meeting)}_path", meeting
  end
  
  def format_sti(action, type, meeting)
    action || meeting ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end
  
  def format_action(action)
    action ? "#{action}_" : ""
  end
end
