class PropertySerializer < ActiveModel::Serializer
  attributes :id, :identifying_name, :display_name, :active
end
