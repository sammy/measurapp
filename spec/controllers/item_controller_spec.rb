require 'rails_helper'

describe ItemsController do 

  describe 'GET new' do

    context 'with authenticated user' do
      
      it 'renders the new template' do
        session[:user] = Fabricate(:user).id
        get :new
        expect(response).to render_template :new
      end
      
      it 'assigns the item instance variable' do
        session[:user] = Fabricate(:user).id
        get :new
        expect(assigns(:item)).to be_kind_of(Item)
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

  describe 'POST create' do 
    
    context 'with authenticated user' do
      it 'creates a new item in the database'
      it 'associates the newly created item with the current user'
      it 'renders the new_item template'
      it 'displays a flash message'
    end

    context 'with non authenticated user' 

  end
end