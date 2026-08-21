class DeleteSubscriberJob < ApplicationJob
  queue_as :default

  def perform(subscriber_id)
    subscriber = Subscriber.find_by(id: subscriber_id)

    return unless subscriber

    subscriber.destroy
  end
end