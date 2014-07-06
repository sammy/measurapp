require 'rails_helper'

describe GroupsController do

  describe 'GET index' do
    
    it_behaves_like 'require login' do
      let(:action) { get :index }
    end

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

  describe 'GET new' do
    
    it_behaves_like 'require login' do
      let(:action) { get :new }
    end

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

  describe 'POST create' do
  
    let(:mike)    { Fabricate(:user) }
    let(:group)   { Fabricate.attributes_for(:group) }
    let(:item_1)  { Fabricate(:item) }
    let(:item_2)  { Fabricate(:item) }

    it_behaves_like 'require login' do
      let(:action) { post :create, group: group.merge(item_ids: [item_1.id, item_2.id]) }
    end

    context 'with valid input' do
      
      before do
        session[:user] = mike.id
        post :create, group: group.merge(item_ids: [item_1.id, item_2.id])
      end

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

  describe "GET edit" do
    
    it_behaves_like "require login" do
      let(:action) { get :edit, id: 'test' }
    end

    it 'renders the edit template' do

    end
    it 'assigns the group instance variable'
    it 'populates the group instance variable with the correct group'


  end
end
