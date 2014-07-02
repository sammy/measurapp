require 'rails_helper'

describe UsersController do 

  describe 'GET new' do
    
    context 'with authenticated user' do
      let(:john) { Fabricate(:user) }
      before { session[:user] = john.id }

      it 'redirects to the home path' do
        get :new
        expect(response).to redirect_to home_path
      end

      it 'displays a flash message' do
        get :new
        expect(flash[:info]).to eq('You are already registered and signed in!')
      end
    end

    context 'without authenticated user' do

      it 'assigns the @user instance variable' do
        get :new
        expect(assigns(:user)).to be_kind_of(User)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      it 'creates a record in the database' do
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'flouts@gmail.com', first_name: 'ap', last_name: 'samat' }
        expect(User.first.username).to eq('sammy')
      end
      it 'displays a flash message'
      it 'redirects you to the login path' do
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'flouts@gmail.com', first_name: 'ap', last_name: 'samat' }
        expect(response).to redirect_to login_path
      end

      it 'send you an registration email'
    end
    context 'with invalid input' do
    end
  end
  
end
