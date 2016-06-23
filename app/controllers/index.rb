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
      new_question = current_user.questions.new(params)
      if new_question.save
        redirect '/'
      else
        @errors = new_question.errors.full_messages
        erb :'/_create_question'
      end
    end
end
