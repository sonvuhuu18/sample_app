class SessionsController < ApplicationController
  def new; end

  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase

    if user&.authenticate(session[:password])
      if user.activated?
        log_in user
        session[:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = t "login.warning"
        redirect_to root_url
      end
    else
      unauthorized_log_in
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def unauthorized_log_in
    flash.now[:danger] = t "login.invalid"
    render :new
  end
end
