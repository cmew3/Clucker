
require 'data_mapper'
require './app/models/cluck'
require './app/models/tag'
require './app/models/user'
require 'sinatra'
require 'rack-flash'
require 'rest-client'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative './helpers/email_sender.rb'
require_relative './helpers/current_user.rb'
require_relative './controllers/users.rb'
require_relative './controllers/sessions.rb'
require_relative './controllers/clucks.rb'
require_relative './controllers/application.rb'


enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

set :partial_template_engine, :erb
set :public_dir, './public'






