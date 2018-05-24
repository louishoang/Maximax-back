# frozen_string_literal: true

require 'spec_helper'

describe Brand do
  context 'when name presents' do
    let(:brand) { FactoryBot.build(:brand) }

    it 'is valid' do
      expect(brand).to be_valid
    end
  end

  context 'when name blank' do
    let(:brand) { FactoryBot.build(:brand, name: nil) }

    it 'is invalid' do
      expect(brand).to be_invalid
    end
  end

  context "when brand's name is duplicate" do
    !let(:brand1) { FactoryBot.create(:brand) }
    let(:brand2) { FactoryBot.build(:brand, name: brand1.name) }

    it 'is invalid' do
      expect(brand2).to be_invalid
    end
  end
end
