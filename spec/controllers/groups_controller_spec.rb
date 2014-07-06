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
      session[:user] = Fabricate(:user).id
      group = Fabricate(:group, user_id: session[:user])
      get :edit, id: group.slug
      expect(response).to render_template :edit
    end

    it 'assigns the group instance variable' do
      session[:user] = Fabricate(:user).id
      group = Fabricate(:group, user_id: session[:user])
      get :edit, id: group.slug
      expect(assigns(:group)).to be_present
    end

    it 'populates the group instance variable with the correct group' do
      session[:user] = Fabricate(:user).id
      group = Fabricate(:group, user_id: session[:user])
      get :edit, id: group.slug
      expect(assigns(:group)).to eq(group)
    end

    it 'assigns the items variable' do
      session[:user] = Fabricate(:user).id
      group = Fabricate(:group, user_id: session[:user])
      2.times { Fabricate(:item, user_id: session[:user]) }
      get :edit, id: group.slug
      expect(assigns(:items)).to be_present
    end

    it 'populates the items variable with items that belong only to the current user' do
      session[:user] = Fabricate(:user).id
      group = Fabricate(:group, user_id: session[:user])
      my_item = Fabricate(:item, user_id: session[:user])
      2.times { Fabricate(:item, user_id: 666) }
      get :edit, id: group.slug
      expect(assigns(:items)).to eq([my_item])
    end
  end

  describe "PUT update" do

    it_behaves_like 'require login' do
      let(:action) { put :update, id: 'some-group' }
    end

    it 'redirects to the view group path' do
      jim = Fabricate(:user)
      set_current_user(jim)
      group = Fabricate(:group, user_id: jim.id)
      put :update, id: group.slug, group: { name: 'a new name' }
      expect(response).to redirect_to group_path(group)
    end

    it 'displays a flash message' do
      jim = Fabricate(:user)
      set_current_user(jim)
      group = Fabricate(:group, user_id: jim.id)
      put :update, id: group.slug, group: { name: 'a new name' }
      expect(flash[:success]).to eq("Group A NEW NAME was successfully updated.")
    end

    it 'assigns the group instance variable' do
      jim = Fabricate(:user)
      set_current_user(jim)
      group = Fabricate(:group, user_id: jim.id)
      put :update, id: group.slug, group: { name: 'a new name' }
      expect(assigns(:group)).to be_present
    end

    it 'updates the name of the group' do
      jim = Fabricate(:user)
      set_current_user(jim)
      group = Fabricate(:group, user_id: jim.id)
      put :update, id: group.slug, group: { name: 'a new name' }
      expect(Group.first.name).to eq('a new name')
    end

    it 'updates the description of the group' do
      jim = Fabricate(:user)
      set_current_user(jim)
      group = Fabricate(:group, user_id: jim.id)
      put :update, id: group.slug, group: { name: group.name, description: 'a new description' }
      expect(Group.first.description).to eq('a new description')
    end

    it 'updates the associated items' do
      jim = Fabricate(:user)
      set_current_user(jim)
      4.times { Fabricate(:item) }
      group = Fabricate(:group, user_id: jim.id, item_ids: [1,2,3,4])
      put :update, id: group.slug, group: { name: group.name, description: group.description, item_ids: [2,4] }
      expect(Group.first.item_ids).to eq([2,4])
    end

    
  end
end
