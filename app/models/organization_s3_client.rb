class OrganizationS3Client
  attr_accessor :organization

  def initialize(organization)
    self.organization = organization
  end

  def get_item_key(sha256)
    "sha256/#{sha256}"
  end

  def get_item_data(sha256)
    get_object(get_item_key sha256).body
  rescue Aws::S3::Errors::NoSuchKey
    nil
  end

  def get_item_text(sha256)
    get_item_data(sha256).string
  end

  def upload_item(content)
    sha256 = DigestConcern::calculate_sha256_for content
    s3_client.put_object(
      bucket: @bucket,
      key: get_item_key(sha256),
      body: content
    )
    sha256
  end

  private

    def s3_client
      return @s3 if @s3.present?

      s3_credential = @organization.service_credentials.s3_access
      return nil if s3_credential.nil?

      info = s3_credential.info

      Aws.config.update({
        region: info.fetch('region'),
        credentials: Aws::Credentials.new(info.fetch('accessKeyID'), info.fetch('secretAccessKey'))
      })

      @s3 = Aws::S3::Client.new(region: info.fetch('region'))
      @bucket = info.fetch('bucket', 'organization-test')

      @s3
    end

    def get_object(key)
      s3_client.get_object(
        bucket: @bucket,
        key: key
      )
    end
end