require 'rails_helper'

describe ResultObjects::Failure do
  it 'should have base result object as parent' do
    expect(described_class.superclass).to eq(ResultObjects::Base)
  end

  describe '.success?' do
    it 'should return true' do
      instance = described_class.new(dummy_data)

      expect(instance.success?).to be_falsy
    end
  end

  describe '.failure?' do
    it 'should return false' do
      instance = described_class.new(dummy_data)

      expect(instance.failure?).to be_truthy
    end
  end

private

  def dummy_data
    [1, 2, 3]
  end
end
