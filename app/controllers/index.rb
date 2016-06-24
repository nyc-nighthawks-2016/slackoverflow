get '/' do
	@questions = Question.all
  erb :index
end

post '/' do
# binding.pry
    if request.xhr?
      new_question = current_user.questions.new(request.params)
      if new_question.save
        status 200
        erb :'_create_question', layout: false, locals: {question: new_question}
      else
        status 422
      end
    else
      redirect '/questions/new'
    end
end

get '/popular' do
	@questions = Question.order(view_count: :desc)
	if request.xhr?
		erb :'tabs/popular', layout: false, locals: {questions: @questions}
	else
		erb :'tabs/popular'
	end
end

get '/newest' do
	@questions = Question.order(created_at: :desc)
	if request.xhr?
		erb :'tabs/newest', layout: false, locals: {questions: @questions}
	else
		erb :'tabs/newest'
	end
end

get '/comments' do

  @questions = Question.all.sort {|x, y| y.comments.length <=> x.comments.length}
  if request.xhr?
    erb :'tabs/comments', layout: false, locals: {questions: @questions}
  else
    erb :'tabs/comments'
  end
end

get '/questionstab' do
  @questions = Question.all
  if request.xhr?
    erb :'tabs/questions', layout: false, locals: {questions: @questions}
  else
    erb :'tabs/questions'
  end
end
