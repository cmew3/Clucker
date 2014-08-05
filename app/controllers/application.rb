get '/' do
	@clucks = Cluck.all.reverse
	erb :index
end

get '/tags/:tag_filter' do
	tag = Tag.first(:text => params[:tag_filter])
	@clucks = tag ? tag.clucks : []
	erb :index
end