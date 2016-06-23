#User register

get '/users/new' do
  erb :'users/new'
end

post '/users' do
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      @errors = @user.errors.full_messages
      erb :'users/new'
    end
end

get '/users' do
  @users = User.all

  erb :'users/index'
end

get '/users/:id' do
  @user = User.find(params[:id])
  @questions = @user.questions
  @answers = @user.answers
  @comments = @user.comments

  erb :'users/show'
end
