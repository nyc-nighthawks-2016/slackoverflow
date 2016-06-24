get '/tags' do
  @tags = Tag.all
  erb :'tags/index'
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions
  erb :'tags/show'
end

get '/new_tags' do
	@tags = Tag.newest
	if request.xhr?
		erb :'tags/new', layout: false, locals: { tags: @tags }
	else
		erb :'tags/new'
	end
end

get '/pop_tags' do
	@tags = Tag.all.sort {|a,b| b.tag_used <=> a.tag_used}
	if request.xhr?
		erb :'tags/pop', layout: false, locals: { tags: @tags }
	else
		erb :'tags/pop'
	end
end

get '/tag_names' do
	@tags = Tag.alphabetize
	if request.xhr?
		erb :'tags/name', layout: false, locals: { tags: @tags }
	else
		erb :'tags/name'
	end
end
