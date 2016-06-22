def logged_in?
  User.exists?(session[:user_id])
end

def current_user
  User.find(session[:user_id])
end

# def redirect_home
#   redirect '/' unless logged_in?
# end
