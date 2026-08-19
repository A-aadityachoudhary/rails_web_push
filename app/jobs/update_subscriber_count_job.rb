class UpdateSubscriberCountJob < ApplicationJob
  queue_as :default

  def perform
    stat = DashboardStat.first_or_create!

    stat.update!(
      subscriber_count: Subscriber.count
    )
  end
end