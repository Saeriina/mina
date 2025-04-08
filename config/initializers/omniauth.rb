Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_API_KEY"], ENV["GOOGLE_API_SECRET_KEY"], {
    scope: "email,profile",
    prompt: "select_account"
  }
end
