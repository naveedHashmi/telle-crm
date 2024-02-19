# frozen_string_literal: true

module DealsHelper
  def deal_statuses
    Deal.statuses.keys.map { |key| [key.to_s.humanize, key] }
  end
end
