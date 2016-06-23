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
