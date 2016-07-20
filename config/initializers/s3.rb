CarrierWave.configure do|config|
 config.fog_credentials = {
  provider:              'AWS',
  aws_access_key_id:     'AKIAJNIIHBWFC4QR4GWQ',
  aws_secret_access_key: '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',
  region:                'us-east-1',
 }
 config.fog_directory = 'turelo-production'
 config.fog_public = 'false'
 config.fog_attributes = {'Cache-Control' => "max-age=#{365.to_i}" }
end
