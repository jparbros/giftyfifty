Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'xJazt51TQ2ZGwUa6LIwcQ', 'Wf3vKm7yYYD4VUKJHoWKUEUIepu68vVdUTOo96IB4mE'
  provider :facebook, '9265497607cecc1f3ee4877400859b89', '46c0ad920327791c06c2cd6713ea98c9'
end