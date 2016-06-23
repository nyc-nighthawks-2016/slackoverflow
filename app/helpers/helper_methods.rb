def logged_in?
  User.exists?(session[:user_id])
end

def current_user
  User.find(session[:user_id])
end

# def redirect_home
#   redirect '/' unless logged_in?
# end

def points
    votes.sum(:value)
  end

def time_since_creation(object)
  ((Time.now - object.created_at) / 3600).round
end
