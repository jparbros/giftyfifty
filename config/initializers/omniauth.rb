require "#{Rails.root.to_s}/app/middleware/event_url"
Rails.application.config.middleware.use EventUrl

Rails.application.config.middleware.insert_before EventUrl, OmniAuth::Builder do
  provider :twitter, TWITTER_CREDENTIALS[:consumer_key], TWITTER_CREDENTIALS[:consumer_secret]
  provider :facebook, FACEBOOK_CREDENTIAL[:client_id], FACEBOOK_CREDENTIAL[:secret_id]
end