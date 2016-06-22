get '/questions/:id' do
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
end
