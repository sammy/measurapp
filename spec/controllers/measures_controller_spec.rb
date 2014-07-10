require 'rails_helper'

describe MeasuresController do

  describe 'GET new' do

    let(:joe) { Fabricate(:user) }

    it_behaves_like 'require login' do
      let(:action) { get :new }
    end

    it 'sets the measure instance variable' do
      set_current_user(joe)
      get :new
      expect(assigns(:measure)).to be_kind_of Measure
    end

  end

  describe 'POST create' do
    
    # let(:joe) { Fabricate(:user) }

    # it_behaves_like 'require login' do
    #   let(:action) { get :new }
    # end

    # before { set_current_user(joe) }

    # context 'with valid input' do
    #   it 'creates a measure object in the database'
    #   it 'links the object to the current user'
    #   it 'renders the new template'
    #   it 'displays a flash message'
    # end

    # context 'with invalid input' do
    #   it 'does not create a record when name is missing'
    #   it 'does not create a record when min_value is missing'
    #   it 'does not create a record when max_value is missing'
    #   it 'renders the new template'
    #   it 'displays an error message'
    # end

  end


end