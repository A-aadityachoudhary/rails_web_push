class SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Subscriber.all
  end

  def create
    subscriber = Subscriber.find_or_initialize_by(
      endpoint: params[:endpoint]
    )

    subscriber.p256dh = params[:keys][:p256dh]
    subscriber.auth   = params[:keys][:auth]
    subscriber.browser = params[:browser]

    location = params[:location] || {}

    subscriber.ip = location[:ip]
    subscriber.country = location[:country]
    subscriber.country_code = location[:country_code]
    subscriber.continent = location[:continent]
    subscriber.continent_code = location[:continent_code]
    subscriber.asn = location[:asn]
    subscriber.as_name = location[:as_name]
    subscriber.as_domain = location[:as_domain]

    if subscriber.save
      render json: {
        success: true,
        message: "subscriber saved"
      }, status: :created
    else
      render json: {
        success: false,
        errors: subscriber.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end