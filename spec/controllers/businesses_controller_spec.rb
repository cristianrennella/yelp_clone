require 'spec_helper'

describe BusinessesController do
	describe "GET index" do
		it "sets @businesses" do
			business1 = Fabricate(:business)
			business2 = Fabricate(:business)
			get :index
			expect(assigns(:businesses)).to match_array([business1, business2])
		end
	end

	describe "GET show" do
		let(:current_user) { Fabricate(:user) }
		let(:business) { Fabricate(:business) }
		
		before do
			session[:user_id] = current_user.id
		end

		it "sets @business" do
			get :show, params: { id: business.id }
			expect(assigns(:business)).to eq(business)
		end

		it "sets @reviews" do
			review1 = Fabricate(:review, business: business, user: current_user)
			review2 = Fabricate(:review, business: business, user: current_user)
			get :show, params: { id: business.id }
			expect(assigns(:reviews)).to match_array([review1, review2])
		end

		it "sets @review" do
			get :show, params: { id: business.id }
			expect(assigns(:review)).to be_instance_of(Review)
		end
	end

	describe "GET new" do
		it "sets @business" do
			get :new
			expect(assigns(:business)).to be_instance_of(Business)
		end
	end

	describe "POST create" do
		context "with valid input" do
			before { post :create, params: { business: Fabricate.attributes_for(:business) } }
			it "creates the business" do
				expect(Business.count).to eq(1)
			end

			it "redirects to the home page" do
				expect(response).to redirect_to root_path
			end
		end

		context "with invalid input" do
			before do
				post :create, params: { business: {address: "123 Crazy Street"} }
			end
			
			it "creates the business" do
				expect(Business.count).to eq(0)
			end

			it "redirects to the new business" do
				expect(response).to render_template :new
			end

			it "sets @business" do
				expect(assigns(:business)).to be_instance_of(Business)
			end
		end
	end
end