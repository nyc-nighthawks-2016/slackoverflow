get '/tags' do
  @tags = Tag.all
  @newest_tags = Tag.newest
  erb :'tags/index'
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions
  erb :'tags/show'
end
