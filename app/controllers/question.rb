get '/questions/:id' do
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
end

post '/questions/:id/upvote' do
  # if request.xhr?
  # else
  unless Vote.find_by(user_id: session[:user_id])
  	Vote.create!(user_id: session[:user_id], votable_id: 1, votable_type: "question", vote_value: 1)
  end
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
  # end
end

post '/questions/:id/downvote' do
  # if request.xhr?
  # else
  unless Vote.find_by(user_id: session[:user_id])
  	Vote.create!(user_id: session[:user_id], votable_id: 1, votable_type: "question", vote_value: -1)
  end
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
  erb :'questions/show'
  # end
end
