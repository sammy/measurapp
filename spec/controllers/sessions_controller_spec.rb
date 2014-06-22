require 'rails_helper'

describe SessionsController do 

  describe 'GET new' do 
    it "redirects to the login page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    
    context 'with valid credentials' do
      it 'redirects to the home page' do
        john = Fabricate(:user)
        post :create, username: john.username, password: john.password
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid credentials'
  end
  

end