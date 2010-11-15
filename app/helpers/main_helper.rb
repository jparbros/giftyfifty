module MainHelper
  def form_path(type)
    case type
    when 'sign-in'
      registration_path(@user)
    when 'login'
      session_path(@user)
    end
  end
  
  def button_label(type)
    case type
    when 'sign-in'
      'Sign Up'
    when 'login'
      'Login'
    end
  end
  
  def submit_search
    submit_tag 'Next', {:id => (user_signed_in?)? 'search-gift': 'go-sign-in'}
  end
  
end
