module ApplicationHelper
  def site_title
    'Royal Icing'
  end

  def page_title
    components = []

    if @organization.present?
      components << "@#{ @organization.name }"
    end

    components << site_title

    components.join(' · ')
  end

  def is_record_taken_error?(error, attribute)
    # See http://stackoverflow.com/a/32231499/652615
    error.details.all? do |hash_element|
      error_details = hash_element[attribute]
      error_details.all? { |detail| detail[:error] == :taken }
    end
  end
end
