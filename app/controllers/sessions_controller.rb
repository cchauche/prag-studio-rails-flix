class SessionsController < ApplicationController
  def create
    email = params[:email]
    password = params[:password]

    pp email
    pp password
  end

  def destroy
  end

  def new
  end
end
