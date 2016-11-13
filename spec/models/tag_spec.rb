require 'rails_helper'

RSpec.describe Tag, type: :model do
  before(:each) do
    @organization = Organization.create!(name: 'test', owner_identifier: 'TEST')
  end

  it "lowercase" do
    tag = Tag.create!(name: 'Hello', organization: @organization)
    expect(tag.name).to eq('hello')
  end
end
