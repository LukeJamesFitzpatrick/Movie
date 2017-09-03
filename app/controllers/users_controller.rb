class UsersController < ApplicationController

def show
   @user = User.find_by(username: params[:username])
   @user_pins = @user.pins
end

end

