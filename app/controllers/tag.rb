get '/tags' do
  @tags = Tag.all
  erb :'tags/index'
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions
  erb :'tags/show'
end

get '/tags/new' do
	@tags = Tag.newest
	if request.xhr?
		erb :'tags/new', layout: false, locals: { tags: @tags }
	else
		erb :'tags/index'
	end
end

get '/tags/popular' do
	@tags = Tag.sort {|a,b| a.tag_used <=> b.tag_used}
	if request.xhr?
		erb :'tags/popular', layout: false, locals: { tags: @tags }
	else
		erb :'tags/popular'
	end
end

get '/tags/name' do
	@tags = Tag.alphabetize
	if request.xhr?
		erb :'tags/name', layout: false, locals: { tags: @tags }
	else
		erb :'tags/name'
	end
end
