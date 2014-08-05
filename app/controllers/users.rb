PASSWORD_RESET_TIMEOUT = 60*60

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
