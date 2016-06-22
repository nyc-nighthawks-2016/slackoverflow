get '/' do
  erb :index
end

#User register

get '/users/new' do
  erb :'users/new'
end

post '/users/new' do
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      @errors = user.errors.full_messages
      erb :'users/new'
    end

end

#User login

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
  end
end

#User Logout

get '/users/logout' do
  session.delete(:user_id)
  redirect '/'
end
