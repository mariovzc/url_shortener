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


post '/url_shortener' do
  params = JSON.parse request.body.read

  url = params['url']

  url_shortener = Link.new(url: url)

  if url_shortener.save
    url_shortener.to_json
  else
    status 400
    body url_shortener.errors.to_json
  end

end