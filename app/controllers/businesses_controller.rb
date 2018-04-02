class BusinessesController < ApplicationController
	def index
		@businesses = Business.all
	end

	def show
		@business = Business.find params[:id]
		@reviews = @business.reviews
		@review = Review.new
	end

	def new
		@business = Business.new
	end

	def create
		@business = Business.new(business_params)

		if @business.save
			flash[:notice] = "You have created a new Business!"
			redirect_to root_path
		else
			render :new
		end
	end

	private

	def business_params
		params.require(:business).permit(:name, :address, :food_type)
	end
end