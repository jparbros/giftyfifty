module GrowlHelper
  
  def growl
    if session[:growl][:active]
      session[:growl][:active] = false
      ret = javascript_tag do
        "$(function() {$.jGrowl('#{session[:growl][:message]}', { sticky: true });});"
      end
    end
  end
end
