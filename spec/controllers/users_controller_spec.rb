require 'spec_helper'

describe UsersController do
	describe "GET new" do
		it "sets @user" do
			get :new
			expect(assigns(:user)).to be_instance_of(User)
		end

		it "renders the register template" do
			user = User.new
			get :new
			expect(response).to render_template :register
		end
	end

	describe "GET show" do
		let(:user) { Fabricate(:user) }

		it "sets @user" do
			get :show, params: { id: user.id }
			expect(assigns(:user)).to eq(user)
		end

		it "sets @reviews" do
			get :show, params: { id: user.id }
			expect(assigns(:reviews)).to eq(user.reviews)
		end

		it "renders the register template" do
			get :show, params: { id: user.id }
			expect(response).to render_template :show
		end
	end

	describe "POST create" do
		context "with valid input" do
			before { post :create, params: { user: Fabricate.attributes_for(:user) } }

			it "creates the user" do
				expect(User.count).to eq(1)
			end

			it "redirects to the home page" do
				expect(session['user_id']).not_to be_nil
			end

			it "redirects to the home page" do
				expect(response).to redirect_to root_path
			end
		end

		context "with invalid input" do
			before do
				post :create, params: { user: {password: "password"} }
			end
			
			it "creates the user" do
				expect(User.count).to eq(0)
			end

			it "redirects to the new template" do
				expect(response).to render_template :register
			end

			it "sets @user" do
				expect(assigns(:user)).to be_instance_of(User)
			end
		end
	end
end