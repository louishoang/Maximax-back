# frozen_string_literal: true

class OptionTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_name
  has_many :option_values
end
