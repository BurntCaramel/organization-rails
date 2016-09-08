module ApplicationHelper
  def is_record_taken_error?(error, attribute)
    # See http://stackoverflow.com/a/32231499/652615
    error.details.all? do |hash_element|
      error_details = hash_element[attribute]
      error_details.all? { |detail| detail[:error] == :taken }
    end
  end
end
