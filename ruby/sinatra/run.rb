require 'sinatra'

get '/' do
  "This is a Sinatra app. Try <a href='/hello'>hello</a>"
end

get '/hello' do
  erb :hello  
end

post '/hello' do
  redirect to("/hello/#{params[:name]}")
end

get '/hello/:name' do |n|
  "Hello #{n}!"
end
