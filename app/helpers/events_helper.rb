module EventsHelper
  def is_owner?
    if current_user
      @event.user == current_user
    else
      false
    end
  end
end
