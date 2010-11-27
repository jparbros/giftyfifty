OAUTH_CREDENTIALS={
  :key=>"MYRtMZPE0k7oNDti67oWtV2KUb0cr7BFJCAOg43T",
  :secret=>"tzsD69jDSerPytNEwuq4orpDn62RnU0Lwz4bRYAy",
  :options=>{
    :site=> (Rails.env.production?)? "http://gifty-api.heroku.com/" : "http://localhost:3000/"
  }
} unless defined? OAUTH_CREDENTIALS

  load 'oauth/models/consumers/service_loader.rb'