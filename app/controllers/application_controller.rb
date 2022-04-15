class ApplicationController < ActionController::Base

  before_action :load_user

  private
  def load_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def user_required
    raise ActiveRecord::RecordNotFound unless @user
  end

end
