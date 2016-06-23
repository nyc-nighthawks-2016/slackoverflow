post '/questions/:id/answers/new' do
  current_question = current_user.questions.find(params :id)
  new_answer = current_user.questions.new(params)
      if new_answer.save
        redirect "/questions/#{current_question.id}/answers"
      else
        @errors = new_answer.errors.full_messages
        erb :'_new_answer'
      end
end
