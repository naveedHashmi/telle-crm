# frozen_string_literal: true

class AnalyticsController < BaseController
  def analytics
    @group_analytics, @commission_pending, @count, @commission_earned = DealService.analytics_data(filter_params)
  end

  private

  def filter_params
    params['filter'] || {}
  end
end
