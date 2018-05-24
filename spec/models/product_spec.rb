# frozen_string_literal: true

require 'spec_helper'

describe Product do
  context 'valid data' do
    let(:product) { FactoryBot.build(:product) }

    it { expect(product).to be_valid }

    it 'is not active on create' do
      product.save
      expect(product.deleted_at).to be <= Time.zone.now
    end

    context 'when meta_keywords is not provided' do
      let(:product) { FactoryBot.build(:product, meta_keywords: nil) }

      it 'sets meta_keywords' do
        product.save
        expect(product.meta_keywords).to be_present
      end
    end

    context 'when meta_description is not provided' do
      let(:product) { FactoryBot.build(:product, meta_description: nil) }

      it 'sets meta_description' do
        product.save
        expect(product.meta_description).to be_present
      end
    end

    context 'when permalink is not set' do
      let(:product) { FactoryBot.build(:product, permalink: nil) }

      it 'sets permalink' do
        product.save
        expect(product.permalink).to be_present
      end
    end
  end
end
