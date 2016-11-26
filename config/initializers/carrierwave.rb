CarrierWave.configure do |config|
  # config.fog_credentials = {
  #   :provider               => 'AWS',                          # required
  #   :aws_access_key_id      => ENV["aws_access_key_id"],       # required
  #   :aws_secret_access_key  => ENV["aws_secret_access_key"],   # required
  # }
  # config.fog_directory  = ENV['fog_directory']       # required
  # config.fog_public     = false                      # optional, defaults to true
  # config.fog_authenticated_url_expiration = 600      # (in seconds) => 10 minutes
end
