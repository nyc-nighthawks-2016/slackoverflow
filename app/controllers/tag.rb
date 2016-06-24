get '/tags' do
  @tags = Tag.all
  erb :'tags/index'
end

get '/tags/new_tags' do
	@tags = Tag.newest
	if request.xhr?
		erb :'tags/new', layout: false, locals: { tags: @tags }
	else
		erb :'tags/index'
	end
end

get '/tags/pop_tags' do
	@tags = Tag.all.sort {|a,b| b.tag_used <=> a.tag_used}
	if request.xhr?
		erb :'tags/pop', layout: false, locals: { tags: @tags }
	else
		erb :'tags/index'
	end
end

get '/tags/tag_names' do
	@tags = Tag.alphabetize
	if request.xhr?
		erb :'tags/name', layout: false, locals: { tags: @tags }
	else
		erb :'tags/index'
	end
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions
  erb :'tags/show'
end

get '/tags/:id/new' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions.order(created_at: :desc)
  if request.xhr?
    erb :'tags/new_q', layout: false, locals: { tag: @tag, questions: @questions }
  else
    erb :'tags/show'
  end
end

get '/tags/:id/votes' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions.order(vote_count: :desc)
  if request.xhr?
    erb :'tags/votes', layout: false, locals: { tag: @tag, questions: @questions }
  else
    erb :'tags/show'
  end
end
