class WelcomesController < ApplicationController
  
  def index
    if !user_signed_in?
      @user = User.where(username: 'guest', last_sign_in_ip: request.remote_ip).try :first
      if @user
        sign_in @user
      else
        sign_in User.as_new_guest
      end
    end
  end
  
  def sign_out_user
    sign_out
    redirect_to root_path
  end
  
  def sign_out_and_sign_up
    sign_out
    redirect_to new_user_registration_path
  end
  
  def sign_out_and_sign_in
    sign_out(current_user)
    redirect_to new_user_session_path
  end
  
end
