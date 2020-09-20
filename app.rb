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

get '/links' do
  Link.all.map { |s| s.to_json }.to_json
end

post '/url_shortener' do
  params = JSON.parse request.body.read
  link = Link.new(url: params['url'])
  unless link.save
    halt 400, link.errors.to_json
  end
  status 201
  {
    shortened_url: link.slug
  }.to_json
end

get '/:slug' do
  link = Link.where(slug: params[:slug]).first
  unless link
    halt 404, { message: "Not found" }.to_json
  end
  link.set_clicked
  redirect link.url
end


delete '/clean' do
  Link.delete_all
  {message:'db restored'}.to_json
end