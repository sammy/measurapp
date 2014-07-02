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

      context 'with valid input' do
      
        it 'creates a new item in the database' do
          session[:user] = Fabricate(:user).id
          post :create, item: { name: 'Item1', description: 'some_text'}
          expect(Item.count).to eq(1)
        end

        it 'associates the newly created item with the current user' do
          john = Fabricate(:user)
          session[:user] = john.id
          post :create, item: { name: 'Item1', description: 'some_text', user_id: john.id }
          expect(john.items.first.name).to eq('Item1')
        end
        
        it 'renders the new_item template' do
          session[:user] = Fabricate(:user).id
          post :create, item: { name: 'Item1', description: 'some_text'}
          expect(response).to render_template :new
        end
        
        it 'displays a flash message'
      end
      
      context 'with invalid input'

    end

    context 'with non authenticated user' 

  end
end