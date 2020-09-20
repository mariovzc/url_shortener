require 'sinatra'
require 'json'
require './model.rb'

set :port, 8000
set :bind, '0.0.0.0'


before do
  content_type :json
end

get '/' do
  {status:'ok'}.to_json
end

