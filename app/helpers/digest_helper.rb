require 'digest'

module DigestHelper
  def calculate_sha256_for(input)
    Digest::SHA256.hexdigest input
  end
end
