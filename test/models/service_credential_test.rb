require 'test_helper'

class ServiceCredentialTest < ActiveSupport::TestCase
  def setup
    @organization = Organization.new
  end

  test "service credentials should validate" do
    cred = ServiceCredential.new

    assert_not cred.valid?

    cred.organization = @organization

    assert_not cred.valid?

    cred.info = {
      'accessKeyID' => 'id',
      'secretAccessKey' => 'secret',
      'region' => 'region'
    }

    assert cred.valid?

    assert_equal 'id', cred.access_key_id
    assert_equal 'secret', cred.secret_access_key
    assert_equal 'region', cred.region
  end
end
