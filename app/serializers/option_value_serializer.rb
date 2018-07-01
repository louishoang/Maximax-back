# frozen_string_literal: true

class OptionValueSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_name, :position
end
