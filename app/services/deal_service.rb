# frozen_string_literal: true

class DealService
  def self.analytics_data
    time_periods = [30, 60, 90]
    time_periods_in_months = [6, 12]
    grouped_deals = {}

    time_periods.each do |days|
      grouped_deals["Past #{days} days"] = Deal.where('created_at >= ?', days.days.ago).count
    end

    time_periods_in_months.each do |months|
      grouped_deals["Past #{months} months"] =
        Deal.where('created_at >= ?', months.months.ago).count
    end

    grouped_deals
  end
end
