# frozen_string_literal: true

require 'spec_helper'

describe Variant do
  context 'valid data' do
    let(:variant) { FactoryBot.build(:variant) }

    it { expect(variant).to be_valid }
  end

  context 'missing attribute' do
    %w[price cost product_id sku].each do |key|
      context "when #{key} is missing" do
        let(:variant) { FactoryBot.build(:variant) }
        before { variant.send("#{key}=", nil) }

        it { expect(variant).to be_invalid }
      end
    end
  end
end
