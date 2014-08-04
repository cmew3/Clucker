
require 'data_mapper'
require './app/models/cluck'
require './app/models/tag'
require './app/models/user'
require 'sinatra'
require 'rack-flash'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
	@clucks = Cluck.all
	erb :index
end

get '/tags/:tag_filter' do
	tag = Tag.first(:text => params[:tag_filter])
	@clucks = tag ? tag.clucks : []
	erb :index
end

get '/users/new' do
	erb :'users/new'
end

post '/users' do
	@user = User.create(name: params[:name],
			email: params[:email],
			user_name: params[:user_name],
			password: params[:password],
			password_confirmation: params[:password_confirmation])
	if @user.save
		puts "user saved"
		session[:user_id] = @user.id
		redirect '/'
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :'users/new'
	end
end

def current_user
	@current_user ||=User.get(session[:user_id]) if session[:user_id]
end

get '/sessions/new' do
	erb :'sessions/new'
end

post '/sessions' do
	user_name, password = params[:user_name], params[:password]
	user = User.authenticate(user_name,password)
	if user
		session[:user_id]=user.id
		redirect '/'
	else
		flash.now[:notice] = "Email or password did not match"
		erb :'sessions/new'
	end
end

delete '/sessions' do
	session[:user_id]=nil
	flash[:notice] = "Goodbye!"
	redirect '/'
end

get '/clucks/new' do
	erb :'clucks/new'
end

post '/clucks' do
	new_cluck=params[:new_cluck]
	current_user.add_cluck(new_cluck)
	redirect '/'
end
