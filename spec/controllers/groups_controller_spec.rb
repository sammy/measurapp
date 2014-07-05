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

      let(:mike)  { Fabricate(:user) }
      let(:group) { Fabricate.attributes_for(:group) }
      
      before do
        session[:user] = mike.id
        post :create, group: group
      end

      it 'redirects to the new_group_path' do
        expect(response).to redirect_to new_group_path
      end

      
      it 'creates a new group in the database'
      it 'assigns the new group to the current user'
      it 'associates selected items with the group'
      
      # it 'displays a flash message' do
      #   expect(flash[:success]).to eq("Group #{group.name} was successfully created!")
      # end
    end

    context 'with non authenticated user'
  end
end