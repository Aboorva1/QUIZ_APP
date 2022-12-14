class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_validation :strip_input_fields


def strip_input_fields
  self.attributes.each do |key, value|
    self[key] = value.strip if value.respond_to?("strip")
  end
end
end
