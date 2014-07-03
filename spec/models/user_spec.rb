require 'rails_helper'

describe User do 
  
  it { should have_many(:groups) }
  it { should have_many(:items) } 
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }  
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }

  describe '#full_name' do
    it 'combines the users first and last name' do
      ellie = Fabricate(:user, first_name: 'Eleftheria', last_name: 'Rozi')
      expect(ellie.full_name).to eq('Eleftheria Rozi')
    end
  end

end