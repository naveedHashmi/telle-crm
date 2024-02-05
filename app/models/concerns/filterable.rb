# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def custom_filter(filtering_params)
      results = where(nil)

      filtering_params.each do |key, value|
        begin
          value = JSON.parse(value)
        rescue StandardError
        end
        value = value.reject(&:blank?) if value.is_a? Array
        unless value.nil? || value == 'All' || value == '' || value.is_a?(Array) && value == ['All']
          results = results.public_send("filter_by_#{key}",
                                        value)
        end
      end
      results
    end
  end
end
