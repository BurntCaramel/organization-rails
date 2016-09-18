require 'aws-sdk'

module S3Helper
  def set_s3_client
    s3_credential = @organization.s3_credentials.first
    if s3_credential.nil?
      redirect_to @organization, alert: 'You must add S3 credentials first'
      return
    end

    Aws.config.update({
      region: s3_credential.region,
      credentials: Aws::Credentials.new(s3_credential.access_key_id, s3_credential.secret_access_key)
    })

    @s3 = Aws::S3::Client.new(region: s3_credential.region)
    @bucket = 'organization-test'
  end

  def get_object(key)
    @s3.get_object(
      bucket: @bucket,
      key: key
    )
  end

  def head_object(key)
    @s3.head_object(
      bucket: @bucket,
      key: key
    )
  end
end