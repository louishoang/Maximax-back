# frozen_string_literal: true

require 'spec_helper'

describe VariantProperty do
  context 'valid data' do
    let(:variant_property) { FactoryBot.build(:variant_property) }

    it { expect(variant_property).to be_valid }
  end
end
