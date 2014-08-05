
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
