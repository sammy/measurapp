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
    
    let(:joe) { Fabricate(:user) }

    it_behaves_like 'require login' do
      let(:action) { get :new }
    end

    before { set_current_user(joe) }

    context 'with valid input' do
      
      it 'creates a measure object in the database' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '0', max_value: '10' }
        expect(Measure.count).to eq(1)
      end

      it 'links the object to the current user' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '0', max_value: '10' }
        expect(Measure.first.user).to eq(joe)
      end

      it 'redirects to the new_measure_path' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '0', max_value: '10' }
        expect(response).to redirect_to new_measure_path
      end

      it 'displays a flash message' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '0', max_value: '10' }
        expect(flash[:success]).to eq("Measure MY_MEASURE successfully created")
      end
    end

    context 'with invalid input' do

      it 'does not create a record when name is missing' do
        post :create, measure: { description: 'text', min_value: '0', max_value: '10' }
        expect(Measure.count).to eq(0)
      end

      it 'does not create a record when min_value is missing' do
        post :create, measure: { name: 'my_measure', description: 'text', max_value: '10' }
        expect(Measure.count).to eq(0)
      end

      it 'does not create a record when max_value is missing' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '10' }
        expect(Measure.count).to eq(0)
      end

      it 'renders the new template' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '10' }
        expect(response).to render_template :new
      end

      it 'displays an error message' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '10' }
        expect(flash[:alert]).to_not be_nil
      end
    end

  end


end