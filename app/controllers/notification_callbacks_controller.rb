class NotificationCallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def notification_delivered
    status = NotificationStatus.find(params[:status_id])

    # Prevent duplicate counting
    return head :ok if status.delivered?

    status.update!(
      status: :delivered
    )

    status.notification_campaign.increment!(:delivered_count)

    head :ok
  end

  def notification_clicked
    status = NotificationStatus.find(params[:status_id])

    status.update!(clicked_at: Time.current)

    status.notification_campaign.increment!(:clicked_count)

    head :ok
  end
end