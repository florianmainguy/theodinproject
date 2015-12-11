if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region => ENV['S3_REGION']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
  
  # Config Heroku
  # heroku config:set S3_ACCESS_KEY=<access key>
  # heroku config:set S3_SECRET_KEY=<secret key>
  # heroku config:set S3_BUCKET=<bucket name>
  # heroku config:set S3_REGION='eu-west-1'
end