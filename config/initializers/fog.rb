CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJOCDPFOU7UTT4HOQ',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'ap-southeast-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'ruuva'                     # required
  config.fog_public     = true                          # optional, defaults to true
end