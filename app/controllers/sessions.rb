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