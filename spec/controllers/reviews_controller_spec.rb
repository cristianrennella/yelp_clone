require 'spec_helper'

describe ReviewsController do
	describe "GET index" do
		it "sets @reviews" do
			user = Fabricate(:user)
			business = Fabricate(:business)
			review1 = Fabricate(:review, user: user, business: business)
			review2 = Fabricate(:review, user: user, business: business)
			get :index
			expect(assigns(:reviews).to_a).to eq([review2, review1])
		end
	end

	describe "POST create" do
		let(:business) { Fabricate(:business) }

		context "with authenticated users" do
			let(:current_user) { Fabricate(:user) }
			before { session[:user_id] = current_user.id }

			context "with valid inputs" do
				before do
					post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
				end

				it "creates the review" do
					expect(Review.count).to eq(1)
				end

				it "redirects to the show page" do
					expect(response).to redirect_to business
				end

				it "creates the review associated with the business" do
					expect(Review.first.business).to eq(business)
				end

				it "creates the review associated with the signed user" do
					expect(Review.first.user).to eq(current_user)
				end
			end

			context "with invalid inputs" do
				it "does not create a review" do
					post :create, params: { review: Fabricate.attributes_for(:review, description: ""), business_id: business.id }
					expect(Review.count).to eq(0)
				end

				it "renders the business/show page" do
					post :create, params: { review: Fabricate.attributes_for(:review, description: ""), business_id: business.id }
					expect(response).to render_template "businesses/show"
				end

				it "sets business" do
					post :create, params: { review: Fabricate.attributes_for(:review, description: ""), business_id: business.id }
					expect(assigns(:business)).to eq(business)
				end
			end
		end

		context "with unauthenticated users" do
			it "redirects the user to the log in page" do
				post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.id }
				expect(response).to redirect_to login_path 
			end
		end
	end
end