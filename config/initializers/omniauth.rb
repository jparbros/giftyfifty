Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER_CREDENTIALS[:consumer_key], TWITTER_CREDENTIALS[:consumer_secret]
  provider :facebook, FACEBOOK_CREDENTIAL[:client_id], FACEBOOK_CREDENTIAL[:secret_id]
end