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

  describe '#groups=' do
    it 'creates a measure item for each group item in the database' do
      measure = Fabricate(:measure)
      group1 = Fabricate(:group)
      group2 = Fabricate(:group)
      item1 = Fabricate(:item)
      item2 = Fabricate(:item)
      item3 = Fabricate(:item)
      GroupItem.create(item_id: item1.id, group_id: group1.id)
      GroupItem.create(item_id: item2.id, group_id: group1.id)
      GroupItem.create(item_id: item3.id, group_id: group2.id)
      GroupItem.create(item_id: item2.id, group_id: group2.id)
      measure.groups = ["", "#{group1.id}", "#{group2.id}"]
      expect(MeasureItem.count).to eq(4)
      expect(item1.measures.count).to eq(1)
      expect(item2.measures.count).to eq(2)
    end
  end

  describe '#range' do
    it 'returns a range object consisting of the min and max range' do
      measure = Fabricate(:measure, min_value: 1, max_value: 100)
      expect(measure.range).to eq(1..100)
    end
  end
end