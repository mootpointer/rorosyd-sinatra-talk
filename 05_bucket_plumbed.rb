require "sinatra/base"
require "json"
require "forwardable"
require "aws"
require "dotenv"

Dotenv.load  # Load environment variables from a local file

class Cabinet < Sinatra::Base

  get "/files" do
    content_type :json
    listing = Listing.new("my-awesome-bucket")
    JSON.dump(listing.files)
  end
end

class Listing
  attr_reader :bucket
  def initialize bucket_name
    @bucket = AWS.s3.buckets[bucket_name]
  end

  def files
    bucket.objects.map {|file| S3File.new(file)}
  end
end

class S3File
  extend Forwardable

  def_instance_delegator :s3_object, :metadata

  attr_accessor :s3_object
  def initialize s3_object
    @s3_object = s3_object
  end

  def name
    metadata.name
  end

  def description
    metadata.description
  end

  def url
    s3_object.url_for(:get)
  end

  def to_h # Oh come now...
    {
      name: name,
      description: description,
      url: url
    }
  end
end


Cabinet.run!
