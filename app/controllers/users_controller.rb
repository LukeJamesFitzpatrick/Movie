class UsersController < ApplicationController

  def show
     @user = User.find(params[:id])
     @user_pins = @user.pins
  end

end
