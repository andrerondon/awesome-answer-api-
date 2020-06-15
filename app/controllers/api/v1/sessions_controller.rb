class Api::V1::SessionsController < Api::ApplicationController
    def create
      user = User.find_by_email params[:email]
      if user&.authenticate params[:password]
        session[:user_id] = user.id
        render json: { id: user.id }
      else
        render(
          # status: 404 -> Set the HTTP Code to 404 ("not found")
          # list of status codes https://www.restapitutorial.com/httpstatuscodes.html
          json: { status: 404, message: 'failed to login' },
          status: 400 # not found
        )
      end
    end
  
    def destroy
      session[:user_id] = nil
      render(
        json: { message: 'Logged out' }, 
        status: 200 # ok
      )
    end
  end
  