require 'rails_helper'

describe Item do 

  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should have_many(:group_items) }
  it { should have_many(:groups) }

end