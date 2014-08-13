require "sinatra/base"
require "json"

class Cabinet < Sinatra::Base

  get "/files" do
    content_type :json # Sinatra Helper!
    files = {
      files: [
        {
          name: "Awesome File.exe",
          description: "Speeds up your PC",
          url: "http://bukkit.s3.amazonaws.com/lolhax.exe?crazy_signing_stuff"
        }
      ]
    }
    JSON.dump(files)
  end
end

Cabinet.run!
