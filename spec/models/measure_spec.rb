require 'rails_helper'

describe Measure do

  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:min_value) }
  it { should validate_presence_of(:max_value) }
  
end