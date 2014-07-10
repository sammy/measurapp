require 'rails_helper'

describe Measure do

  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:min_value) }
  it { should validate_presence_of(:max_value) }
  # it { should validate(:correct_range) }
  
  describe '#type' do
    
    it 'returns boolean if range is 0 to 1' do
      Fabricate(:measure, min_value: 0, max_value: 1)
      expect(Measure.first.type).to eq('Boolean')
    end

    it 'returns scale if range is not 0 to 1' do
      Fabricate(:measure, min_value: 0, max_value: 10)
      expect(Measure.first.type).to eq('Scale')
    end
  end

  describe '#range' do
    it 'returns a range object with the minimum and maximum values' do
      measure = Fabricate(:measure, min_value: 0, max_value: 10)
      expect(measure.range).to eq(0..10)
    end
  end
end