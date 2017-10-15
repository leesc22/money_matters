Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'], scope: 'email, public_profile', info_fields: 'name, email', display: 'popup', client_options: { ssl: { ca_file: '/usr/lib/ssl/certs/ca-certificates.crt' }}
end