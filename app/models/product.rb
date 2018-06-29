# frozen_string_literal: true

class Product < ApplicationRecord
  STATUS_PENDING = 'Pending'
  STATUS_ACTIVE = 'Active'
  STATUS_DELETED = 'Deleted'

  extend FriendlyId
  friendly_id :permalink, use: :finders

  serialize :product_keywords, Array
  serialize :meta_keywords, Array

  belongs_to :brand
  belongs_to :category
  has_many :product_properties
  has_many :properties, through: :product_properties
  has_many :variants
  has_many :active_variants, -> { where(deleted_at: nil) }, class_name: 'Variant'
  has_many :product_images, -> { order(:position) }, dependent: :destroy

  before_validation :sanitize_data
  before_validation :not_active_on_create!, on: :create

  validates :category_id, presence: true
  validates :name,             presence: true,   length: { maximum: 165 }
  validates :meta_keywords,    presence: true,   length: { maximum: 255 }
  validates :permalink,        uniqueness: true, length: { maximum: 150 }
  validates :meta_description, presence: true,   length: { maximum: 255 }

  def status
    return STATUS_PENDING if available_at.nil? || deleted_at.nil?

    current_time = Time.now
    if current_time < available_at
      STATUS_PENDING
    elsif current_time.between?(available_at, deleted_at)
      STATUS_ACTIVE
    else
      STATUS_DELETED
    end
  end

  def as_json(*)
    super.tap do |hash|
      hash['status'] = status
      hash[:sku] = sku
      hash[:price] = price
      hash[:images] = product_images.map do |image|
        {
          id: image.id,
          url: Rails.application.routes.url_helpers.rails_blob_url(image.file)
        }
      end
      hash
    end
  end

  def master_variant
    variants.where(master: true).first || NullVariant.new
  end

  def sku
    master_variant.sku
  end

  def price
    master_variant.price
  end

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
    ]
  end
end
