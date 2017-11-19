class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # login the user
    else
      flash.now[:danger] = 'The email or password you entered is not correct.'
      render 'new'
    end
  end

  def destroy

  end
end
