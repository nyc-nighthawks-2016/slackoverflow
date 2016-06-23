get '/questions/:id' do
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
end

post '/questions/:id' do
  # if request.xhr?
  # else
  @question = Question.find(params[:id])
  erb :'questions/show'
  # end
end
