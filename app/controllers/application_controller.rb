class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_user_is_creator?, :admin_logged_in?, :current_user_is_admin?, :user_is_current_user?, :user_is_current_user_or_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def user_is_current_user?
    @user == current_user
  end

  def user_is_current_user_or_admin?
    user_is_current_user? || current_user_is_admin?
  end

  def admin_logged_in?
    logged_in? && (!current_user.user_type.nil? && current_user.user_type.downcase == "admin")
  end

  def current_user_is_admin?
    !current_user.user_type.nil? && (current_user.user_type == "admin")
  end

  def require_user
    if !logged_in?
      must_be_logged_in
    end
  end

  def current_user_is_creator?(created_object)
    current_user == created_object.creator
  end

  def require_admin
    if !logged_in?
      must_be_logged_in
    elsif !admin_logged_in?
      must_be_admin
    end
  end

  private
  def must_be_logged_in
    flash[:error] = "Must be logged in to do that."
    redirect_to root_path
  end

  def must_be_admin
    flash[:error] = "You aren't allowed to do that."

      redirect_to root_path

  end

end
