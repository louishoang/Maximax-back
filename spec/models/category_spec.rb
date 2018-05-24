# frozen_string_literal: true

require 'spec_helper'

describe Category do
  context 'when name presents' do
    let(:category) { FactoryBot.build(:category) }

    it 'is valid' do
      expect(category).to be_valid
    end
  end

  context 'when name blank' do
    let(:category) { FactoryBot.build(:category, name: nil) }

    it 'is invalid' do
      expect(category).to be_invalid
    end
  end
end
