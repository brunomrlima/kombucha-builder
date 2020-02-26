module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_attributes(attributes)
      results = self.where(nil)
      attributes.each do |key, value|
        puts key
        puts value
        results = results.public_send("filter_by_#{key}", JSON.parse(value)) if value.present?
      end
      results
    end
  end
end