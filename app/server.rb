
require 'data_mapper'
require './app/models/cluck'
require './app/models/tag'
require './app/models/user'
require 'sinatra'
require 'rack-flash'
require 'rest-client'
require_relative 'data_mapper_setup'

PASSWORD_RESET_TIMEOUT = 60*60

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
	@clucks = Cluck.all.reverse
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
	@user = User.new(name: params[:name],
			email: params[:email],
			user_name: params[:user_name],
			password: params[:password],
			password_confirmation: params[:password_confirmation])
	if @user.save
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
	tags = params[:tags].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end
	current_user.add_cluck(new_cluck, tags)
	redirect '/'
end

get '/users/reset_password' do
	erb :'users/reset_password'
end

post '/users/reset_password' do
	email = params[:email]
	if user = User.first(:email => email)
		user.set_reset_token
		send_password_reset(user.email,create_link(user.password_token))
		flash[:notice] = "A link to reset you password will be sent to your email shortly"
		redirect '/'
	else
		flash[:notice] = "Email not recognised"
		redirect '/users/reset_password'
	end
end

get '/users/reset_password/:token' do
	token = params[:token]
	@user = User.first(:password_token => token)
	if @user && (Time.now-@user.password_token_timestamp) < PASSWORD_RESET_TIMEOUT
		erb :'users/new_password'
	else
		flash.now[:notice] = "Sorry your password reset has timed out"
		erb :'users/reset_password'
	end
end

post '/users/set_new_password' do
	@user = User.first(	:email =>params[:email])
	if @user.reset_password(params[:password], params[:password_confirmation])
	session[:user_id] = @user.id
	redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :'users/new_password'
	end
end

def create_link password_token
	"#{request.url.to_s}/#{password_token.to_s}"
end

def send_password_reset(email, link)
  RestClient.post "https://api:key-d733bc88a2fb89d47ef91cfa2a5fb31a"\
  "@api.mailgun.net/v2/sandbox8e90015459c74825b6714ab541d9ac60.mailgun.org/messages",
  :from => "Bookmark Manager <postmaster@sandbox8e90015459c74825b6714ab541d9ac60.mailgun.org>",
  :to => "<#{email}>",
  :subject => "Password Reset",
  :text => "Please click the link below to reset your password\n#{link}."
end
