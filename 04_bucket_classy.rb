require "sinatra/base"
require "json"

class Cabinet < Sinatra::Base

  get "/files" do
    content_type :json # Sinatra Helper!
    listing = Listing.new(bucket)
    JSON.dump(listing.files)
  end
end

class Listing
  attr_reader :bucket
  def initialize bucket_name
    @bucket = bucket_name
  end

  def files
    {
      files: [
        {
          name: "Awesome File.exe",
          description: "Speeds up your PC",
          url: "http://bukkit.s3.amazonaws.com/lolhax.exe?crazy_signing_stuff"
        }
      ]
    }
  end
end

Cabinet.run!
