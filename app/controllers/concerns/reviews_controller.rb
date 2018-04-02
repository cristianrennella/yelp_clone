class ReviewsController < ApplicationController
	before_action :require_user, only: [:create]

	def index
		@reviews = Review.all.order(updated_at: :desc)
	end

	def create
		@business = Business.find params[:business_id]
		review = @business.reviews.new(params.require(:review).permit(:description))
		review.user = current_user

		if review.save
			flash[:success] = "Your review was added"
			redirect_to @business
		else
			flash[:danger] = "Your review was not added"
			@reviews = @business.reviews.reload
			@review = review
			render 'businesses/show'
		end
	end
end