json.extract! organization_invitation, :id, :organization_id, :email, :created_at, :updated_at
json.url organization_invitation_url(organization_invitation, format: :json)