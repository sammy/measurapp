require 'rails_helper'

describe GroupsController do

  describe 'GET index' do
    
    context 'with authenticated user' do
      
      it 'renders the index template' do
        session[:user] = Fabricate(:user).id
        get :index
        expect(response).to render_template :index
      end

      it 'assigns the groups instance variable' do
        session[:user] = Fabricate(:user).id
        get :index
        expect(assigns(:groups)).to_not be_nil        
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

  describe 'POST create' do
    
    context 'with authenticated user' do

      let(:mike)    { Fabricate(:user) }
      let(:group)   { Fabricate.attributes_for(:group) }
      let(:item_1)  { Fabricate(:item) }
      let(:item_2)  { Fabricate(:item) }
      
      before do
        session[:user] = mike.id
        post :create, group: group.merge(item_ids: [item_1.id, item_2.id])
      end

      context 'with valid input' do
        

        it 'redirects to the new_group_path' do
          expect(response).to redirect_to new_group_path
        end

        
        it 'creates a new group in the database' do
          expect(Group.last.name).to eq(group[:name])
          expect(Group.last.description).to eq(group[:description])
        end

        it 'assigns the new group to the current user' do
          expect(Group.last.user_id).to eq(mike.id)
        end

        it 'associates selected items with the group' do
          expect(Group.last.items).to eq([item_1, item_2])
        end

        it 'displays a flash message' do
          expect(flash[:success]).to eq("Group #{group[:name]} was successfully created!")
        end
      end

      context 'with invalid input' do

        it 'does not save the group if name is not present' do
          group[:name] = nil
          expect(Group.count).to eq(0)
        end
      end
    end

    context 'with non authenticated user' do
    end
  end

end
