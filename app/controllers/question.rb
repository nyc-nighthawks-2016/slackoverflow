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
  view_count = @question.view_count
  view_count += 1
  @question.update_attributes(view_count: view_count)
  erb :'questions/show'
end

post '/questions/:id' do
  current_question = Question.find(params[:id])
  new_answer = current_question.answers.new(user: current_user, answer: params[:answer])
  @question = Question.find(params[:id])
  @question_author = User.find(@question.user_id)
      if new_answer.save
        redirect "/questions/#{current_question.id}"
      else
        @errors = new_answer.errors.full_messages
        erb :'/questions/show'
      end
end

post '/questions/:id/upvote' do
  if request.xhr?
    @question = Question.find(request[:id])
    @question_author = User.find(@question.user_id)
    if session[:user_id]
      unless Vote.find_by(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question")
        Vote.create!(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question", vote_value: 1)
      end
      # binding.pry
      content_type :json
      { id: request[:id], votes: @question.votes }.to_json
    end
  else
    @question = Question.find(params[:id])
  	@question_author = User.find(@question.user_id)
    if session[:user_id]
  	  unless Vote.find_by(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question")
  	  	Vote.create!(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question", vote_value: 1)
  	  end
  	end
  end
  redirect "/questions/#{params[:id]}" #should this be inside the section statement?
end

post '/questions/:id/downvote' do
  if request.xhr?
    @question = Question.find(request[:id])
    @question_author = User.find(@question.user_id)
      if session[:user_id]
        unless Vote.find_by(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question")
        Vote.create!(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question", vote_value: -1)
        end
        # binding.pry
        content_type :json
        { id: request[:id], votes: @question.votes }.to_json
      end
  else
    @question = Question.find(params[:id])
    # binding.pry
  	@question_author = User.find(@question.user_id)
      if session[:user_id]
    	  unless Vote.find_by(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question")
    	  	Vote.create!(user_id: session[:user_id], votable_id: @question.id, votable_type: "Question", vote_value: -1)
	      end
	    end
	end
	redirect "/questions/#{params[:id]}" #should this be inside the section statement?
end


post '/answers/:id/upvote' do
  # if request.xhr?
  # else
  answer = Answer.find(params[:id])
	@question = answer.question
	@question_author = User.find(@question.user_id)
  if session[:user_id]
	  unless Vote.find_by(user_id: session[:user_id], votable_id: answer.id, votable_type: "Answer")
	  	Vote.create!(user_id: session[:user_id], votable_id: answer.id, votable_type: "Answer", vote_value: 1)
	  end
	  # end
	end
  redirect "/questions/#{@question.id}"
end


post '/answers/:id/downvote' do
  # if request.xhr?
  # else
  answer = Answer.find(params[:id])
	@question = answer.question
	@question_author = User.find(@question.user_id)
  if session[:user_id]
	  unless Vote.find_by(user_id: session[:user_id], votable_id: answer.id, votable_type: "Answer")
	  	Vote.create!(user_id: session[:user_id], votable_id: answer.id, votable_type: "Answer", vote_value: -1)
	  end
	  # end
	end
	redirect "/questions/#{@question.id}"
end

post '/questions/:id/comments/new' do
  @question = Question.find(params[:id])
  new_comment = @question.comments.new(user: current_user, comment: params[:comment])
  @question_author = User.find(@question.user_id)
      if new_comment.save
        redirect "/questions/#{@question.id}"
      else
        @errors = new_comment.errors.full_messages
        erb :'/questions/show'
      end
end

post '/questions/:q_id/answers/:id/comments/new' do
  @question = Question.find(params[:q_id])
  @answer = Answer.find(params[:id])
  new_comment = @answer.comments.new(user: current_user, comment: params[:comment])
  @question_author = User.find(@question.user_id)
      if new_comment.save
        redirect "/questions/#{@question.id}"
      else
        @errors = new_comment.errors.full_messages
        erb :'/questions/show'
      end
end


# Adding edit and delete answer/comment functionality
get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  if current_user.id == @question.user_id
    erb :'questions/edit_question'
  else
    redirect "/questions/#{@question.id}"
  end
end

put '/questions/:id' do
  question = Question.find(params[:id])
  question.assign_attributes(params[:edit])
  if question.save
    redirect "/questions/#{question.id}"
  else
    @errors = question.errors.full_messages
  end
end

delete '/questions/:id' do
  question = Question.find(params[:id])
  question.destroy
  redirect '/'
end

get '/questions/:q_id/comments/:id/edit' do
  @question = Question.find(params[:q_id])
  @comment = Comment.find(params[:id])
  if current_user.id == @comment.user_id
    erb :'questions/edit_question_comment'
  else
    redirect "/questions/#{@question.id}"
  end
end

put '/questions/:q_id/comments/:id' do
  comment = Comment.find(params[:id])
  comment.update_attribute(:comment, params[:new_comment])
  if comment.save
    redirect "/questions/#{params[:q_id]}"
  else
    @errors = question.errors.full_messages
  end
end

delete '/questions/:q_id/comments/:id' do
  comment = Comment.find(params[:id])
  comment.destroy
  redirect "/questions/#{params[:q_id]}"
end

get '/questions/:q_id/answers/:id/edit' do
  @question = Question.find(params[:q_id])
  @answer = Answer.find(params[:id])
  if current_user.id == @answer.user_id
    erb :'questions/edit_question_answer'
  else
    redirect "/questions/#{@question.id}"
  end
end

put '/questions/:q_id/answers/:id' do
  answer = Answer.find(params[:id])
  answer.update_attribute(:answer, params[:new_answer])
  if answer.save
    redirect "/questions/#{params[:q_id]}"
  else
    @errors = question.errors.full_messages
  end
end

delete '/questions/:q_id/answers/:id' do
  answer = Answer.find(params[:id])
  answer.destroy
  redirect "/questions/#{params[:q_id]}"
end

get '/questions/:q_id/answers/:a_id/comments/:id/edit' do
  @question = Question.find(params[:q_id])
  @answer = Answer.find(params[:a_id])
  @comment = Comment.find(params[:id])
  if current_user.id == @comment.user_id
    erb :'questions/edit_answer_comment'
  else
    redirect "/questions/#{@question.id}"
  end
end

put '/questions/:q_id/answers/:a_id/comments/:id' do
  comment = Comment.find(params[:id])
  comment.update_attribute(:comment, params[:new_comment])
  if comment.save
    redirect "/questions/#{params[:q_id]}"
  else
    @errors = question.errors.full_messages
  end
end

delete '/questions/:q_id/answers/:a_id/comments/:id' do
  comment = Comment.find(params[:id])
  comment.destroy
  redirect "/questions/#{params[:q_id]}"
end
