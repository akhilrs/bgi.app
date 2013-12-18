class UsersController < ApplicationController
  def new
  	@title = "Registration"
  	@users = User.new
  end

  def create
  	@users = User.new(params[:user])
  	if(@users.save)
  		flash[:notice] = "You signed up successfully!"
  		flash[:color] = "valid"
	else
		flash[:notice] = "Form is invalid!"
		flash[:color] = "invalid"
	end
	render "new" 
  end


  private

  def user_params
  	params.require(:user).permit(:fname, :lname, :email, :password, :mobileno)
  end
end
