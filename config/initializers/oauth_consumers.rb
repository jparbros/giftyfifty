OAUTH_CREDENTIALS={
  :key=>"MYRtMZPE0k7oNDti67oWtV2KUb0cr7BFJCAOg43T",
  :secret=>"tzsD69jDSerPytNEwuq4orpDn62RnU0Lwz4bRYAy",
  :options=>{
    :site=> (Rails.env.production?)? "http://gifty-api.heroku.com/" : "http://localhost:3000/"
  }
} unless defined? OAUTH_CREDENTIALS

load 'oauth/models/consumers/service_loader.rb'

TWITTER_CREDENTIALS = {
  :consumer_key => 'xJazt51TQ2ZGwUa6LIwcQ',
  :consumer_secret => 'Wf3vKm7yYYD4VUKJHoWKUEUIepu68vVdUTOo96IB4mE'
}