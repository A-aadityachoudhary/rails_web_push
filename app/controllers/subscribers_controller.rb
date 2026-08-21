class SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Subscriber.all
  end

  def create
  location = params[:location] || {}

  subscription_data = {
    "endpoint" => params[:endpoint],
    "p256dh" => params.dig(:keys, :p256dh),
    "auth" => params.dig(:keys, :auth),
    "browser" => params[:browser],

    "ip" => location[:ip],
    "country" => location[:country],
    "country_code" => location[:country_code],
    "continent" => location[:continent],
    "continent_code" => location[:continent_code],
    "asn" => location[:asn],
    "as_name" => location[:as_name],
    "as_domain" => location[:as_domain]
  }

  CreateSubscriberJob.perform_later(subscription_data)

  render json: {
    success: true,
    message: "subscriber creation queued"
  }, status: :accepted
end

  def destroy
      subscriber_id = params[:id]

      DeleteSubscriberJob.perform_later(subscriber_id)

      render json: {
        message: "Subscriber deletion queued successfully"
      }, status: :accepted
    end
end