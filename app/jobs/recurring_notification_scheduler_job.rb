class RecurringNotificationSchedulerJob < ApplicationJob
  queue_as :default

  def perform
    Recurring.active.find_each do |recurring|
      SendRecurringNotificationJob.perform_later(recurring.id)
    end
  end
end