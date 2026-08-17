class PageVisitsController < ApplicationController
  skip_forgery_protection only: :create

  def create
    Rails.logger.info "========== PAGE VISIT BEACON RECEIVED =========="
    Rails.logger.info "Params: #{params.to_unsafe_h}"
    uuid = params[:subscriber_uuid]
    subscription = PushSubscription.find_by(subscriber_uuid: uuid) if uuid.present?

    PageVisit.create!(
      page: params[:page],
      started_at: parse_time(params[:started_at]),
      left_at: parse_time(params[:left_at]),
      duration_seconds: params[:duration_seconds].to_i,
      subscriber_uuid: uuid,
      push_subscription: subscription
    )

  

    head :ok
  rescue => e
    Rails.logger.error "Page visit tracking failed: #{e.message}"

    head :unprocessable_entity
  end

  private

  def parse_time(value)
    return nil if value.blank?

    Time.zone.parse(value)
  end
end