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

# get '/questions/:id' do
#   @question = Question.find(params[:id])
#   @question_author = User.find(@question.user_id)
#   erb :'questions/show'
# end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  view_count = @question.view_count
  view_count += 1
  @question.update_attributes(view_count: view_count)
  erb :'questions/show'
end

post '/questions/:id/upvote' do
  # if request.xhr?
  # else
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  unless Vote.find_by(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question")
  	Vote.create!(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question", vote_value: 1)
  end
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
  # end
end

post '/questions/:id/downvote' do
  # if request.xhr?
  # else
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  unless Vote.find_by(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question")
  	Vote.create!(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question", vote_value: -1)
  end
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
  # end
end


