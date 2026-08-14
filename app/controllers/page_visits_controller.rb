class PageVisitsController < ApplicationController
  skip_forgery_protection only: :create

  def create
    Rails.logger.info "========== PAGE VISIT BEACON RECEIVED =========="
    Rails.logger.info "Params: #{params.to_unsafe_h}"
    PageVisit.create!(
      page: params[:page],
      started_at: parse_time(params[:started_at]),
      left_at: parse_time(params[:left_at]),
      duration_seconds: params[:duration_seconds].to_i,
      push_subscription_id: params[:push_subscription_id]
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