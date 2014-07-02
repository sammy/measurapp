require 'rails_helper'

describe User do 
  
  it { should have_many(:groups) } 
  it { should validate_presence_of(:username) }

  describe '#full_name' do
    it 'combines the users first and last name' do
      ellie = Fabricate(:user, first_name: 'Eleftheria', last_name: 'Rozi')
      expect(ellie.full_name).to eq('Eleftheria Rozi')
    end
  end

end