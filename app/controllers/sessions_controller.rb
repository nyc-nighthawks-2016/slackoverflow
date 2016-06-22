#User login

get '/sessions/login' do
  erb :'sessions/login'
end

post '/sessions/login' do
  @user = User.find_by(email: params[:email])
  if @user
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      # binding.pry
      @errors = @user.errors.full_messages
      erb :'sessions/login'
    end
  else
    @errors = ['User does not exist!!!']
    erb :'sessions/login'
  end
end

#User Logout

get '/sessions/logout' do
  session.delete(:user_id)
  redirect '/'
end
