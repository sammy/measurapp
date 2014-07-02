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
      it 'redirects to the root_path'
      it 'displays a flash message'
    end
  end
end