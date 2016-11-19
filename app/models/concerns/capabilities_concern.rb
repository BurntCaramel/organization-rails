module CapabilitiesConcern
  extend ActiveSupport::Concern

  def capabilities
    @capabilities_set ||= (self[:capabilities] || '').split(',').map(&:to_sym).to_set
  end

  def capabilities=(input)
    @capabilities_set = Array.wrap(input).map(&:to_sym).to_set
    write_attribute(:capabilities, @capabilities_set.to_a.join(','))
  end 
end