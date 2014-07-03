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
          post :create, item: { name: 'Item1', description: 'some_text' }
          expect(john.items.first.name).to eq('Item1')
        end

        it 'associates the new item with the selected groups' do
          john = Fabricate(:user)
          group_one = Fabricate(:group)
          group_two = Fabricate(:group)
          group_three = Fabricate(:group)
          session[:user] = john.id
          post :create, item: { name: 'Item1', description: 'some_text', group_ids: [1,3] }
          expect(Item.first.groups).to eq([group_one, group_three])
        end
        
        it 'redirects to the new_item_path' do
          session[:user] = Fabricate(:user).id
          post :create, item: { name: 'Item1', description: 'some_text'}
          expect(response).to redirect_to new_item_path
        end
        
        it 'displays a flash message' do
          session[:user] = Fabricate(:user).id
          post :create, item: { name: 'Item1', description: 'some_text'}
          item = Item.first
          expect(flash[:success]).to eq("Item #{item.name.upcase} has been succesfully created")          
        end
      end
      
      context 'with invalid input' do
        it 'does not create an item when the name is not present' do
          session[:user] = Fabricate(:user)
          post :create, item: { description: 'some_text'}
          expect(Item.count).to eq(0)
        end

        it 'displays an error message' do
          session[:user] = Fabricate(:user)
          post :create, item: { description: 'some_text'}
          expect(flash[:error]).to eq(["Name can't be blank"])
        end
      end
    end

    context 'with non authenticated user' do
      it 'redirects to the root_path' do
        post :create, item: { description: 'some_text'}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET edit' do 

    context 'with authenticated user' do 

      let(:item) { Fabricate(:item) }

      before do
        session[:user] = Fabricate(:user)
        get :edit, id: item.id
      end

      it 'renders the edit form' do
        expect(response).to render_template :edit
      end
      
      it 'sets the item instance variable' do
        expect(assigns(:item)).to be_kind_of Item
      end

      it 'assigns the correct item to the instance variable' do
        expect(assigns(:item)).to eq(item)
      end
    end
    
    context 'with non authenticated user' do
      
      it 'redirects to the root_path' do
        get :edit, id: item.id
        expect(response).to redirect_to root_path
      end

      it 'displays an error message' do
        get :edit, id: item.id
        expect(flash[:alert]).to eq('Not authorized! You must sign in first.')
      end
    end
  end
end