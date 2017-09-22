class ApplicationController < ActionController::API

  # this will take a hash and return a jwt token
  def issue_token(payload)
    JWT.encode(payload, ENV['SECRET'], ENV['ALGO'])
  end

  def decode_token(token)
    begin
      JWT.decode(token, ENV["SECRET"], ENV["ALGO"])
    rescue JWT::DecodeError
      return nil
    end
  end

  def token
    if bearer_token = request.headers["Authorization"]
      jwt_token = bearer_token.split(" ")[1]
    else
      # no return
    end
  end

  def current_user
    decoded_hash = decoded_token(token)
    if !decoded_hash.empty?
      user_id = decoded_hash[0]["user_id"]
      user = User.find(user_id)
    else
    end
  end

  def logged_in?
    !!current_user
  end


  def authorized
    redirect_to '/api/v1/login' unless logged_in?
  end

  #authorization
end
