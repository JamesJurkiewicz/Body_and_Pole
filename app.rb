require 'sinatra'
require 'mongoid'
require 'pony'
require 'json'
require 'rubygems'
require 'google_drive'


# Setup database connection
Mongoid.load!("mongoid.yml")
#Person.destroy_all

get '/'  do
  erb :index
end

get '/index'  do
  erb :index
end


get '/about_us'  do
  erb :about_us
end

get '/classes'  do
  erb :classes
end

get '/instructors'  do
  erb :instructors
end

get '/sign_up'  do
  erb :sign_up
end

get '/contact'  do
  erb :contact
end

get '/gallery'  do
  erb :gallery
end

get '/sign_in'  do
  erb :sign_in
end

post '/sign_up' do 
  name=   params[:name]
  email=  params[:email]
  level=  params[:class].split.last
  date=   parmas[:class].split.first

  @person= Pole_sign_up.new(:name => name, :email => email, :start_date => date, :level => level)


end 
