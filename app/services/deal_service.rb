# frozen_string_literal: true

class DealService
  def self.analytics_data(filer_params = {})
    time_periods = [30, 60, 90]
    time_periods_in_months = [6, 12]
    grouped_deals = {}
    commission_earned = {}
    deals = Deal.custom_filter(filer_params)
    closed_deals = deals.where(status: 'closed', included: true)

    time_periods.each do |days|
      grouped_deals["Past #{days} days"] = deals.where('deals.updated_at >= ?', days.days.ago).count
      commission_earned["Past #{days} days"] =
        closed_deals.where('deals.updated_at >= ?', days.days.ago).sum(:expected_commission)
    end

    time_periods_in_months.each do |months|
      grouped_deals["Past #{months} months"] =
        deals.where('deals.updated_at >= ?', months.months.ago).count
      commission_earned["Past #{months} months"] =
        closed_deals.where('deals.updated_at >= ?', months.months.ago).sum(:expected_commission)
    end

    commission_pending_deals = deals.where.not(status: 'closed')
    commission_pending = deals.where.not(status: %w[closed paid]).sum(:expected_commission).to_f
    count = commission_pending_deals.count

    [grouped_deals, commission_pending, count, commission_earned]
  end
end
