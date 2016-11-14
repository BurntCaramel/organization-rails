require 'aws-sdk'

module S3Helper
  include DigestHelper

  def set_s3_client
    s3_credential = @organization.service_credentials.s3_access
    if s3_credential.nil?
      redirect_to @organization, alert: 'You must add S3 credentials first'
      return
    end

    info = s3_credential.info

    Aws.config.update({
      region: info.fetch('region'),
      credentials: Aws::Credentials.new(info.fetch('accessKeyID'), info.fetch('secretAccessKey'))
    })

    @s3 = Aws::S3::Client.new(region: info.fetch('region'))
    @bucket = 'organization-test'
  end

  ## Convenience

  def get_item_key(sha256)
    "sha256/#{sha256}"
  end

  def get_item_text(sha256)
    begin
      get_object(get_item_key sha256).body.string
    rescue Aws::S3::Errors::NoSuchKey
      nil
    end
  end

  def upload_item(content)
    sha256 = calculate_sha256_for content
    put_object(get_item_key(sha256), content)
    sha256
  end

  private

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

    def put_object(key, body)
      @s3.put_object(
        bucket: @bucket,
        key: key,
        body: body
      )
    end
end