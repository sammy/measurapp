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
      
      it 'displays a flash message' do
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'flouts@gmail.com', first_name: 'ap', last_name: 'samat'  }
        expect(flash[:success]).to eq('You have registered successfully. Check your mailbox!')
      end
      
      it 'redirects you to the login path' do
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'flouts@gmail.com', first_name: 'ap', last_name: 'samat' }
        expect(response).to redirect_to login_path
      end

      it 'send you an registration email' do
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'flouts@gmail.com', first_name: 'ap', last_name: 'samat' }
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
    end

    context 'with invalid input' do

      it 'does not create a user when username is not present' do
        post :create, user: { password: 'pass', password_confirmation: 'pass', email: 'f@f.com', first_name: 'Some', last_name: 'One' }
        expect(User.count).to eq(0)
      end

      it 'does not create a user when username already exists' do
        sammy = Fabricate(:user, username: 'sammy')
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'flouts@gmail.com', first_name: 'ap', last_name: 'samat' }
        expect(User.count).to eq(1)
      end

      it 'does not create a user when email is not present' do
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', first_name: 'ap', last_name: 'samat' }
        expect(User.count).to eq(0)
      end

      it 'does not create a user when email already exists' do
        sammy = Fabricate(:user, email: 'sammy@home.com')
        post :create, user: { username: 'sammy', password: 'password', password_confirmation: 'password', email: 'sammy@home.com', first_name: 'ap', last_name: 'samat' }
        expect(User.count).to eq(1)
      end

      it 'does not create a user when password and password confirmation do not match'
      it 'does not create a user when first name is not present'
      it 'does not create a user when last name is not present'
      it 'does not send an email to the user'
      it 'renders the new template'


    end


  end
end
