module DigestConcern
  extend ActiveSupport::Concern

  def self.calculate_sha256_for(input)
    Digest::SHA256.hexdigest input
  end
end