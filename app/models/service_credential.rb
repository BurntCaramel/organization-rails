require 'json'

class ServiceCredential < ApplicationRecord
  belongs_to :organization

  attr_encrypted :info, key: :encryption_key, encode: false, encode_iv: false, marshal: true, marshaler: JSON

  validates :organization, presence: true
  validates :info, presence: true
  validate :validate_info_contents

  S3_ACCESS_SERVICE_ID = 'aws.s3.access'
  IMGIX_SERVICE_ID = 'imgix'
  TRELLO_SERVICE_ID = 'trello'

  KINDS = [
    S3_ACCESS_SERVICE_ID,
    IMGIX_SERVICE_ID,
    TRELLO_SERVICE_ID
  ]

  KIND_TO_INFO_KEYS = {
    S3_ACCESS_SERVICE_ID => ['accessKeyID', 'secretAccessKey', 'region'],
    IMGIX_SERVICE_ID => ['host'],
    TRELLO_SERVICE_ID => ['token']
  }

  scope :kind, -> (kind) { where(kind: kind) }
  def self.s3_access 
    self.kind(S3_ACCESS_SERVICE_ID).first
  end
  def self.imgix
    self.kind(IMGIX_SERVICE_ID).first
  end
  def self.trello
    self.kind(TRELLO_SERVICE_ID).first
  end

  KIND_TO_TITLES = {
    S3_ACCESS_SERVICE_ID => 'S3',
    IMGIX_SERVICE_ID => 'imgix',
    TRELLO_SERVICE_ID => 'Trello'
  }

  def self.title_for_kind(kind)
    KIND_TO_TITLES.fetch(kind)
  end

  def kind_display
    ServiceCredential.title_for_kind(kind)
  end

  def info_keys
    KIND_TO_INFO_KEYS.fetch(kind)
  end

  def encryption_key
    Rails.application.secrets.service_credentials_key
  end

  class HashMethodAccessor < Hash
    def self.from(other_hash)
      hash = HashMethodAccessor.new
      hash.merge!(other_hash)
      hash
    end

    def method_missing(method, *opts)
      m = method.to_s
      if self.has_key?(m)
        return self[m]
      end
    end
  end

  def info_proxy
    HashMethodAccessor.from(info)
  end

  private

    def validate_info_contents
      if info.nil?
        errors.add(:info, 'should have :info attribute')
        return
      end

      if kind == S3_ACCESS_SERVICE_ID
        errors.add(:info, 'should contain "accessKeyID"') if info['accessKeyID'].nil?
        errors.add(:info, 'should contain "secretAccessKey"') if info['secretAccessKey'].nil?
        errors.add(:info, 'should contain "region"') if info['region'].nil?
      end
    end
end
