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

	erb :'tabs/popular'
end

get '/newest' do
	@questions = Question.order(created_at: :desc)

	erb :'tabs/newest'
end
