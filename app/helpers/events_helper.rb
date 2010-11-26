module EventsHelper
  def is_owner?
    if current_user
      @event['event']['user_id'].to_i == current_user.id
    else
      false
    end
  end
end
