class SubscriberCountJob < ApplicationJob
  queue_as :default

  def perform(action)
    stats = DashboardStat.first_or_create!(
      subscriber_count: 0,
      notification_count: 0,
      campaign_count: 0
    )

    case action.to_sym
    when :increment
      stats.increment!(:subscriber_count)

    when :decrement
      stats.decrement!(:subscriber_count) if stats.subscriber_count > 0
    end
  end
end