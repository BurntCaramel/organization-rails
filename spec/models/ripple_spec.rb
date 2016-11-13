require 'rails_helper'

RSpec.describe Ripple, type: :model do
  before(:all) do
    Organization.delete_all
    Channel.delete_all
    @ateam = Organization.create!(name: 'The B Team', owner_identifier: 'owner123')
    @channel = Channel.create!(organization: @ateam, name: 'A-Team One')
    @a3 = @channel.ripples.build(
      key_id: "86ABE6C65C069418",
      info: { 'name' => 'NAME' },
      created_at: 7.hours.ago
    )
  end

  it "should be valid" do
    @ripple = @channel.ripples.build(info: { 'kind' => 'text' })
    expect(@ripple.valid?).to be true
  end

  it "key_id should be present" do
    ripple = @channel.ripples.build(info: { 'kind' => 'text' })
    ripple.key_id = nil
    expect(ripple.valid?).to be false
  end

  it "info should be present" do
    ripple = @channel.ripples.build
    expect(ripple.valid?).to be false
  end

  it "kind should match" do
    ripple = @channel.ripples.build(info: { 'kind' => 'text' })
    expect(ripple.kind).to eq :text 
  end

  it "name successor should be valid with same key" do
    a3 = @a3

    new_info = {
      'name' => 'Hello'
    }
    a4 = a3.succeed_with(new_info)
    expect(a3.key_id).to eq a4.key_id
    expect(new_info).to eq a4.info
    expect(a4.name).to eq 'Hello'
    expect(a4.deleted?).to be false
    expect(a4.validate!).to be true
  end

  it "delete successor should be valid with same key" do
    a3 = @a3

    new_info = {
      'delete' => true
    }
    a4 = a3.succeed_with(new_info)
    expect(a3.key_id).to eq a4.key_id
    expect(a4.info).to eq({
      'delete' => true,
      'name' => 'NAME'
    })
    expect(a4.deleted?).to be true
    expect(a4.validate!).to be true
  end
end
