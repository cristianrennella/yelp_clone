class UsersController < ApplicationController
	def show
		@user = User.find params[:id]
		@reviews = @user.reviews
	end

	def new
		@user = User.new
		render :register
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:notice] = "You have registered!"
			session[:user_id] = @user.id
			redirect_to root_path
		else
			render :register
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end