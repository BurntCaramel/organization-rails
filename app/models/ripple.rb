require 'securerandom'
require 'base64'

class Ripple < ApplicationRecord
  belongs_to :channel
  default_scope -> { order(created_at: :desc) }
  scope :by_key, -> (key_id) { where(key_id: key_id) }
  scope :by_key_64, -> (key_64) { where(key_id: key_from_base64(key_64)) }

  serialize :info, JSON
  validates :channel, presence: true
  validates :key_id, presence: true, length: { is: 16 }
  validates :info, presence: true
  after_initialize :set_defaults, unless: :persisted?

  def organization
    channel.organization
  end

  def kind
    info['kind'].try(:to_sym)
  end

  def item_sha256
    info['sha256']
  end

  def item_tag_relationships
    sha256 = info['sha256']
    return if sha256.nil?
    organization.tag_relationships_for_item(sha256)
  end

  def name
    info['name']
  end

  def deleted?
    info.fetch('delete', false)
  end

  def succeed_with(new_info)
    copy = self.dup

    base_info = self.info.slice('name')
    copy.info = base_info.merge(new_info)

    copy
  end

  def self.latest
    first
  end

  def self.oldest
    last
  end

  def self.current_by_key(key_id)
    self.by_key(key_id).latest
  end

  def self.key_from_base64(key_base64)
    Base64.decode64(key_base64)
  end

  def key_base64
    Base64.encode64(key_id)
  end

  def key_hex_color_1
    @key_hex ||= key_id.unpack('H*')[0] 
    @key_hex[0, 6]
  end

  def key_hex_color_2
    @key_hex ||= key_id.unpack('H*')[0] 
    @key_hex[-6..-1]
  end

  private

    def self.generate_key_id
      SecureRandom.random_bytes(16)
    end

    def set_defaults
      self.key_id ||= self.class.generate_key_id
    end
end
