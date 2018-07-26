# frozen_string_literal: true

require 'spec_helper'

describe Cart do
  context 'factory' do
    let(:cart) { FactoryBot.build(:cart) }

    it 'is valid' do
      expect(cart).to be_valid
    end
  end

  describe '#before_save' do
    describe '#prevent_cart_item_duplication' do
      let(:cart) { FactoryBot.create(:cart) }
      let(:variant) { FactoryBot.create(:variant) }
      let!(:first_item) { FactoryBot.create(:cart_item, cart: cart, variant: variant) }

      before do
        FactoryBot.create(:cart_item, cart: cart, variant: variant)
      end

      context 'when there are two cart_items with the same variant_id' do
        it 'create one cart_item only' do
          expect(cart.cart_items.count).to eq(1)
        end

        it 'increase the quantity of the cart_item' do
          expect(cart.cart_items.first.quantity).to eq(2)
        end
      end
    end
  end
end
