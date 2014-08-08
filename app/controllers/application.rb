get '/' do
	@clucks = Cluck.all.reverse
	@tags = Tag.all
	erb :index
end

get '/tags/:tag_filter' do
	tag = Tag.first(:text => params[:tag_filter])
	@clucks = tag ? tag.clucks : []
	@tags=Tag.all
	if @clucks == []
		flash[:notice]="No clucks matching your search"
		redirect '/'
	else
		erb :index
	end
end

post '/tags' do
  tag_filter = params[:tag_filter]
  puts tag_filter.inspect
    if tag_filter !="none"
	  redirect "/tags/#{tag_filter}"
	else
		redirect '/'
	end
end