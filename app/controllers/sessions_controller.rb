#User login

get '/sessions/login' do
  erb :'sessions/login'
end

post '/sessions/login' do
  if request.xhr?
    # binding.pry
    @user = User.find_by(email: request[:email])
    # binding.pry
    if @user
      if @user.authenticate(request[:password])
        session[:user_id] = @user.id
        status 200
        '/'
      else
        status 422
        @errors = @user.errors.full_messages
      end
    else
      status 422
      @errors = ['User does not exist!!!']
    end
  else
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        @errors = @user.errors.full_messages
        erb :'sessions/login'
      end
    else
      @errors = ['User does not exist!!!']
      erb :'sessions/login'
    end
  end

end

#User Logout

get '/sessions/logout' do
  session.delete(:user_id)
  redirect '/'
end
