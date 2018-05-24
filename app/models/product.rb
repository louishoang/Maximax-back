# frozen_string_literal: true

class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :permalink, use: :finders

  serialize :product_keywords, Array

  belongs_to :brand
  belongs_to :category
  has_many :product_properties
  has_many :properties, through: :product_properties
  has_many :variants
  has_many :active_variants, -> { where(deleted_at: nil) }, class_name: 'Variant'

  before_validation :sanitize_data
  before_validation :not_active_on_create!, on: :create

  validates :category_id, presence: true
  validates :name,             presence: true,   length: { maximum: 165 }
  validates :meta_keywords,    presence: true,   length: { maximum: 255 }
  validates :permalink,        uniqueness: true, length: { maximum: 150 }
  validates :meta_description, presence: true,   length: { maximum: 255 }

  private

  # Set deleted_at to Time.now on create so that product won't be shown immediately
  # when other properties aren't set yet
  def not_active_on_create!
    self.deleted_at ||= Time.zone.now
  end

  def sanitize_data
    sanitize_permalink
    assign_meta_keywords if meta_keywords.blank? && description
    sanitize_meta_description
  end

  def sanitize_permalink
    self.permalink = name if permalink.blank? && name
    self.permalink = permalink.squeeze(' ').strip.tr(' ', '-') if permalink
  end

  def sanitize_meta_description
    return unless name && description.present? && meta_description.blank?

    self.meta_description = [name.first(55), description.remove_hyper_text.first(197)].join(': ')
  end

  def assign_meta_keywords
    self.meta_keywords = [
      name.first(55),
      description
        .remove_non_alpha_numeric # remove non-alpha numeric
        .remove_hyper_text # remove hyper text
        .remove_words_less_than_x_characters # remove words less than 2 characters
        .first(197) # limit to 197 characters
    ].join(': ')
  end
end
