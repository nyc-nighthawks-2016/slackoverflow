get '/tags' do
  @tags = Tag.all
  erb :'tags/index'
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  @questions = @tag.questions
  @newest_tags = Tag.newest
  erb :'tags/show'
end
