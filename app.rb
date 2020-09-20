require 'sinatra'
require 'json'

set :port, 8000
set :bind, '0.0.0.0'


before do
  content_type :json
end

get '/' do
  {status:'ok'}
end


after do
  response.body = JSON.dump(response.body)
end