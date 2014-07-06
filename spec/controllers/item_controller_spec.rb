require 'rails_helper'

describe ItemsController do 

  describe 'GET new' do
      
    it_behaves_like 'require login' do
      let(:action) { get :new }
    end

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

  describe 'POST create' do 
    
    it_behaves_like 'require login' do
      let(:action) { post :create, item: { name: 'Item1', description: 'some_text' } }
    end

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
        post :create, item: { name: 'Item1', description: 'some_text', group_ids: [group_one.id , group_three.id] }
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

  describe 'GET edit' do 

    let(:item) { Fabricate(:item) }

    before do
      session[:user] = Fabricate(:user)
      get :edit, id: item.slug
    end

    it_behaves_like 'require login' do
      let(:action) { get :edit, id: item.slug }
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

  describe 'GET index' do
    
    let(:item1) { Fabricate(:item, name: 'item one', user_id: 1) }
    let(:item2) { Fabricate(:item, name: 'item two', user_id: 1) }

    context 'with authenticated user' do

      it 'renders the index template' do
        session[:user] = Fabricate(:user).id
        get :index
        expect(response).to render_template :index
      end

      it 'assigns the items instance variable' do
        session[:user] = Fabricate(:user).id
        get :index
        expect(assigns(:items)).to_not be_nil
      end

      it 'populates the items variable with all items belonging to the user' do
        session[:user] = Fabricate(:user).id
        get :index
        expect(assigns(:items)).to eq( [item1, item2] )        
      end 
    end

    context 'with non authenticated user' do

      it 'redirects to the root_path' do
        get :index
        expect(response).to redirect_to root_path
      end

      it 'displays a flash message' do
        get :index
        expect(flash[:alert]).to eq('You must first sign in to access this page.')
      end
    end
  end

  describe 'PUT update' do
        
      

      let(:item) { Fabricate(:item, name: 'my item', description: 'my description', group_ids: [1,2,3])}

      context 'with authenticated user' do
        
        it 'redirects to the view item path' do
          session[:user] = Fabricate(:user).id
          put :update, id: item.id, item: {name: 'my new item'}
          expect(response).to redirect_to item_path(item)
        end

        it 'correctly updates the name' do
          session[:user] = Fabricate(:user).id
          put :update, id: item.id, item: {name: 'my new item', description: 'my description'}          
          expect(Item.first.name).to eq('my new item')
        end

        it 'correctly updates the description' do
          session[:user] = Fabricate(:user).id
          put :update, id: item.id, item: {name: 'my item', description: 'my new description'}         
          expect(Item.first.description).to eq('my new description')
        end
        
        it 'correctly updates the associated groups' do
          5.times { Fabricate(:group) }
          session[:user] = Fabricate(:user).id
          put :update, id: item.id, item: {name: 'my item', description: 'my description', group_ids: [3,5]}
          expect(Item.first.group_ids).to eq([3,5])          
        end
        
        it 'displays a flash message' do
          5.times { Fabricate(:group) }
          session[:user] = Fabricate(:user).id
          put :update, id: item.id, item: {name: 'my item', description: 'my description', group_ids: [3,5]}
          expect(flash[:success]).to eq("Item successfully updated.")                    
        end
      end

      context 'with non authenticated user' do
        
        it 'redirects to the root_path' do
          put :update, id: 5
          expect(response).to redirect_to root_path
        end

        it 'displays a flash message' do
          get :update, id: 5
          expect(flash[:alert]).to eq('You must first sign in to access this page.')
        end        
      end
    end

    describe 'GET show' do

      let(:john) { Fabricate(:user) }
      let(:item) { Fabricate(:item, user_id: john.id) }
      let(:item2) { Fabricate(:item) }

      context 'with authenticated user' do
        
        it 'renders the show template' do
          session[:user] = john.id
          get :show, id: item.id
          expect(response).to render_template :show
        end
        
        it 'assigns the item variable' do 
          session[:user] = john.id
          get :show, id: item.id
          expect(assigns(:item)).to_not be_nil          
        end

        it 'assigns the correct item in the item variable' do
          session[:user] = john.id
          get :show, id: item.id
          expect(assigns(:item)).to eq(item)                   
        end

        it 'does not show another users items' do
          session[:user] = john.id
          get :show, id: item2.id
          expect(response).to redirect_to items_path
        end

        it 'diplays a flash message if user tries to access another users item, or non existent item' do
          session[:user] = john.id
          get :show, id: item2.id
          expect(flash[:info]).to eq('Item does not exist!')
        end
      end

      context ' with non authenticated user' do
        it 'redirects to the root_path' do
          get :show, id: item.id
          expect(response).to redirect_to root_path
        end

        it 'displays a flash message' do
          get :show, id: item.id
          expect(flash[:alert]).to eq('You must first sign in to access this page.')
        end
      end
    end
end