require 'rails_helper'

describe MeasuresController do

  describe 'GET index' do

    let(:joe)       { Fabricate(:user) }
    let(:measure)   { Fabricate(:measure, user_id: joe.id) }

    it_behaves_like 'require login' do
      let(:action) { get :index }
    end

    before { set_current_user(joe) }

    it 'assigns the measures instance variable with the current users measures' do
      get :index
      expect(assigns(:measures)).to eq([measure])
    end
  end

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

    it 'sets the groups instance variable' do
      set_current_user(joe)
      get :new
      expect(assigns(:groups)).to be_present
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

      it 'does not save the object if minimum value is bigger than maximum value' do
        post :create, measure: { name: 'my_measure', description: 'text', min_value: '10', max_value: '0' }
        expect(Measure.count).to eq(0)
      end
    end
  end

  describe 'GET show' do

    let(:user)          { Fabricate(:user) }
    let(:measure)       { Fabricate(:measure, user_id: user.id)}
    let(:other_measure) { Fabricate(:measure) }

    it_behaves_like 'require login' do
      let(:action) { get :show, id: 'someid'}
    end

    it 'assigns the measure instance variable' do
      set_current_user(user)
      get :show, id: measure.slug
      expect(assigns(:measure)).to be_present
    end

    it 'assigns the correct measure in the instance variable' do
      set_current_user(user)
      get :show, id: measure.slug
      expect(assigns(:measure)).to eq(measure)
    end
    
    it 'does not show another users measure' do
      set_current_user(user)
      get :show, id: other_measure.slug
      expect(response).to redirect_to home_path
      expect(flash[:alert]).to eq('Measure not found!')    
    end
  end

  describe 'DELETE destroy' do

    let(:user)      { Fabricate(:user) }
    let(:measure)   { Fabricate(:measure, user_id: user.id) }
    let(:other_measure) { Fabricate(:measure) }

    it_behaves_like 'require login' do
      let(:action) { delete :destroy, id: measure.slug }
    end

    it 'sets the measure instance variable' do
      set_current_user(user)
      delete :destroy, id: measure.slug
      expect(assigns(:measure)).to be_present
    end

    it 'deletes the measure from the database' do  
      set_current_user(user)
      delete :destroy, id: measure.slug
      expect(Measure.find_by(slug: measure.slug)).to be_nil
    end

    it 'redirects to the measures path' do
      set_current_user(user)
      delete :destroy, id: measure.slug
      expect(response).to redirect_to measures_path
    end

    it 'displays a flash message' do
      set_current_user(user)
      delete :destroy, id: measure.slug
      expect(flash[:success]).to eq("Measure #{measure.name.upcase} has been successfully deleted")
    end

    it 'does not delete another users measures' do
      set_current_user(user)
      delete :destroy, id: other_measure.slug
      expect(flash[:alert]).to eq('Measure not found')
      expect(Measure.find_by(slug: other_measure.slug)).to_not be_nil
    end
  end
end