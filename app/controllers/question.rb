get '/questions/new' do
  if logged_in?
  erb :_new_question
  else
    redirect '/sessions/login'
  end
end

post '/questions' do
  new_question = current_user.questions.new(params)
      if new_question.save
        redirect "/question/#{new_question.id}"
      else
        @errors = new_question.errors.full_messages
        erb :'_new_question'
      end
end

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
