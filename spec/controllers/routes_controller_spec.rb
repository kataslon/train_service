require 'rails_helper'

describe RoutesController do
	shared_examples 'full access to routes' do
		describe "GET #index" do
			it "populated an array of route" do
				route_1 = create(:route)
				route_2 = create(:route)
				get :index
				expect(assigns(:routes)).to match_array([route_1, route_2])
			end

			it "renders the :index template" do
				get :index
				expect(response).to render_template :index
			end
		end

		describe "GET #new" do
			it "assings a new Route to @route" do
				get :new
				expect(assigns(:route)).to 	be_a_new(Route)
			end

			it "renders the :new template" do
				get :new
				expect(response).to render_template :new
			end
		end

		describe "GET #edit" do
			it "assigns hte requested route to @route" do
				route = create(:route)
				get :edit, id: route
				expect(assigns(:route)).to eq route
			end

			it "renders the :edit template" do
				route = create(:route)
				get :edit, id: route
				expect(response).to render_template :edit
			end
		end

		describe "POST #create" do
			it "saves the new route in the database" do
				expect{post :create, route: attributes_for(:route)}.to change(Route, :count).by(1)
			end

			it "redirect to routes#index" do
				post :create, route: attributes_for(:route)
				expect(response).to redirect_to routes_path
			end

			it "re-renders to :new template with invalid attributes" do
				post :create, route: attributes_for(:invalid_route)
				expect(response).to render_template :new
			end
		end

		describe "PATCH #update" do
			before :each do
				@route = create(:route, name: 'route_1',
																speed: 120)
			end

			context "valid attributes" do
				it "locates the requested @route" do
					patch :update, id: @route, route: attributes_for(:route)
					expect(assigns(:route)).to eq @route
				end

				it "changes @route's attributes" do
					patch :update, id: @route, 
					      route: attributes_for(:route, name: 'route_1',
					      	                            speed: 120)
					@route.reload
					expect(@route.name).to eq('route_1')
					expect(@route.speed).to eq(120)
				end

				it "it redirect to the routes#index " do
					patch :update, id: @route, route: attributes_for(:route)
					expect(response).to redirect_to routes_path
				end
			end

			context "with invalid attributes" do
				it "changes @route's attributes" do
					patch :update, id: @route, 
					      route: attributes_for(:route, name: '2_route',
					      	                            speed: nil)
					@route.reload
					expect(@route.name).to_not eq('2_route')
					expect(@route.speed).to eq(120)
				end

				it "re-renders the edit template" do
					patch :update, id: @route,
					      route: attributes_for(:route, name: '2_route',
					      	                            speed: nil)
					expect(response).to render_template :edit
				end
			end
		end

		describe "DELETE #destroy" do
			before :each do
				@route = create(:route)
			end

			it "delete the route" do
				expect{
					delete :destroy, id: @route
				}.to change(Route, :count).by(-1)
			end

			it "redirect to routes#index" do
				delete :destroy, id: @route
				expect(response).to redirect_to routes_path
			end
		end
	end

	describe "administrator access" do
		before :each do
			sign_in create(:admin)
		end

		it_behaves_like 'full access to routes'
	end

	describe "user access" do
		before :each do
			sign_in create(:user)
		end

		it_behaves_like 'full access to routes'
	end	

	describe "guest access" do

    describe 'GET #new' do
      it "requires login" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        route = create(:route)
        get :edit, id: route
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:route),
          route: attributes_for(:route)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'PUT #update' do
      it "requires login" do
        put :update, id: create(:route),
          route: attributes_for(:route)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:route)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end