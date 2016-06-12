require 'rails_helper'

describe ResultObjects::Base do
  describe '.success?' do
    it 'should return false' do
      instance = described_class.new(dummy_data)

      expect(instance.success?).to be_falsy
    end
  end

  describe '.failure?' do
    it 'should return false' do
      instance = described_class.new(dummy_data)

      expect(instance.failure?).to be_falsy
    end
  end

  describe '.data' do
    it 'should return correct data' do
      instance = described_class.new(dummy_data)

      expect(instance.data).to eq(dummy_data)
    end
  end

private

  def dummy_data
    [1, 2, 3]
  end
end
