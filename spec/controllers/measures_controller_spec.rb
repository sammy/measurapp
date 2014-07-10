require 'rails_helper'

describe MeasuresController do

  describe 'GET new' do

    it_behaves_like 'require login' do
      let(:action) { get :new }
    end

    context 'with valid input' do
      it 'creates a measure object in the database' 
      it 'links the object to the current user'
      it 'renders the new template'
      it 'displays a flash message'
    end

    context 'with invalid input' do
      it 'does not create a record when name is missing'
      it 'does not create a record when min_value is missing'
      it 'does not create a record when max_value is missing'
      it 'renders the new template'
      it 'displays an error message'
    end

  end


end