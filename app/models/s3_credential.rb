require 'json'

class S3Credential < ApplicationRecord
  belongs_to :organization

  attr_encrypted :info, key: :encryption_key, encode: false, encode_iv: false, marshal: true, marshaler: JSON

  validates :organization, presence: true
  validates :info, presence: true
  validate :validate_info_contents

  def access_key_id
    info['accessKeyID']
  end

  def secret_access_key
    info['secretAccessKey']
  end

  def region
    info['region']
  end

  def encryption_key
    Rails.application.secrets.s3_credentials_key
  end

  private

    def validate_info_contents
      if info.nil?
        errors.add(:info, 'should have :info attribute')
        return
      end

      errors.add(:info, 'should contain "accessKeyID"') if info['accessKeyID'].nil?
      errors.add(:info, 'should contain "secretAccessKey"') if info['secretAccessKey'].nil?
      errors.add(:info, 'should contain "region"') if info['region'].nil?
    end
end
