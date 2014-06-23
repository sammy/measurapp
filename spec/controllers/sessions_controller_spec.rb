require 'rails_helper'

describe SessionsController do 

  describe 'GET new' do
    
    context "with non authenticated user" do 
      
      it "renders the login page" do
        get :new
        expect(response).to render_template :new
      end

    end

    context "with authenticated user" do

      it "redirects to the home path" do
        john = Fabricate(:user)
        session[:user] = john.id
        get :new
        expect(response).to redirect_to home_path
      end

    end
  end

  describe 'POST create' do
    
    context 'with valid credentials' do
      
      it 'redirects to the home page' do
        john = Fabricate(:user)
        post :create, username: john.username, password: john.password
        expect(response).to redirect_to home_path
      end
 
      it 'displays a successful login message' do
        john = Fabricate(:user)
        post :create, username: john.username, password: john.password
        expect(flash[:success]).to eq('You have logged in!')
      end

      it 'sets the session cookie' do
        john = Fabricate(:user)
        post :create, username: john.username, password: john.password
        expect(session[:user]).to eq john.id
      end

    end

    context 'with invalid credentials' do
      it 'renders the login template' do
        john = Fabricate(:user)
        post :create, username: john.username, password: 'wrong'
        expect(response).to render_template :new
      end

      it 'displays a flash error message' do
        john = Fabricate(:user)
        post :create, username: john.username, password: 'wrong'
        expect(flash[:alert]).to eq('Login Failed. Wrong username or password.')
      end
    end
  end

  describe 'DELETE destroy' do
    context 'if not logged in' do
      it 'redirects to login page' do
        delete :destroy
        expect(response).to redirect_to login_path
      end
      it 'shows a flash message' do
        delete :destroy
        expect(flash[:alert]).to eq('You are not authorized to view this page. You have to be logged in')
      end
    end
    context 'while logged in' do

      let(:john) { Fabricate(:user) }

      before do
        session[:user] = john.id
        delete :destroy
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to login_path
      end 
      it 'destroys the session' do
        expect(session[:user]).to be_nil
      end
      it 'displays a flash message' do
        expect(flash[:alert]).to eq("Hi #{john.first_name}, you have successfully logged out!")
      end
    end

  end
end