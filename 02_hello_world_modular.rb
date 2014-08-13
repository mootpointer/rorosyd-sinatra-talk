require "sinatra/base"

class Hello < Sinatra::Base
  get "/" do
    "Hello World."
  end
end

Hello.run!
