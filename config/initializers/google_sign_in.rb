Rails.application.configure do
  config.google_sign_in.client_id = Rails.application.credentials.client_id
  config.google_sign_in.client_secret = Rails.application.credentials.client_secret
end
