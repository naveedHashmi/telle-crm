class AnalyticsController < BaseController
  def analytics
    @analytics = DealService.analytics_data
  end
end
