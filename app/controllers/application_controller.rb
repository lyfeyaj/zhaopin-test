class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def all_online_users
    User.where('username is not ? and online = ?', 'guest', true).count
  end
  
  def all_online_guests
    User.where(username: 'guest', online: true).count
  end

  def user_signed_in?
    if current_user.try(:username) == 'guest'
      false
    else
      super
    end
  end
  
  def sign_in(resource_or_scope, *args)
    super(resource_or_scope, *args)
    current_user.update(online: true)
  end
  
  def sign_out(resource_or_scope=nil)
    if current_user || user_signed_in?
      current_user.update(online: false)
    end
    super(resource_or_scope)
  end
  
  helper_method :all_online_users, :all_online_guests, :user_signed_in?
  
end
