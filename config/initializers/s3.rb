CarrierWave.configure do|config|
 config.fog_credentials = {
  provider:              'AWS',
  aws_access_key_id:     'AKIAJKZ5KRRHYHE44VHA',
  aws_secret_access_key: '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',
  region:                'us-east-1',
 }
 config.fog_directory = 'turelo-prod'
 config.fog_public = 'false'
 config.fog_attributes = {'Cache-Control' => "max-age=#{365.to_i}" }
end
