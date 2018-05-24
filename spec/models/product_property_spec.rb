# frozen_string_literal: true

require 'spec_helper'

describe ProductProperty do
  let(:product_property) { FactoryBot.build(:product_property) }

  context 'when product_id and property_id both present' do
    it 'is valid' do
      expect(product_property).to be_valid
    end
  end

  context 'when property_id is missing' do
    let(:product_property) { FactoryBot.build(:product_property, product_id: nil) }

    it 'is invalid' do
      expect(product_property).to be_invalid
    end
  end

  context 'when product_id is missing' do
    let(:product_property) { FactoryBot.build(:product_property, property_id: nil) }

    it 'is invalid' do
      expect(product_property).to be_invalid
    end
  end
end
