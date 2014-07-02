require 'rails_helper'

describe GroupsController do

  describe 'GET index' do
    
    context 'with authenticated user' do
      
      it 'renders the index template' do
        session[:user] = Fabricate(:user).id
        get :index
        expect(response).to render_template :index
      end
    end
    

    context 'with non authenticated user' do
      
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to root_path
      end

      it 'displays an error messsage' do
        get :index
        expect(flash[:alert]).to eq('You must first sign in to access this page.')
      end
    end
  end

  describe 'GET new' do

    context 'with authenticated user' do
      
      it 'renders the new template' do
        session[:user] = Fabricate(:user).id
        get :new
        expect(response).to render_template :new
      end

      it 'sets the group instance variable' do
        session[:user] = Fabricate(:user).id
        get :new
        expect(assigns(:group)).to be_kind_of(Group)
      end
    end

    context 'without authenticated user' do
      
      it 'redirects to the root_path' do
        get :new
        expect(response).to redirect_to root_path
      end

      it 'displays a flash message' do
        get :new
        expect(flash[:alert]).to eq('You must first sign in to access this page.')
      end
    end
  end
end