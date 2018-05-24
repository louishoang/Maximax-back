# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:inventory) { FactoryBot.build(:inventory) }

  it { expect(inventory).to be_valid }
end
