class PushSubscriptionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        render json: PushSubscription.all
    end

    def create
       subscription = PushSubscription.find_or_initialize_by(
        endpoint: params[:endpoint]
    )

    subscription.p256dh = params[:keys][:p256dh]
    subscription.auth   = params[:keys][:auth]
    subscription.browser = params[:browser]
    location = params[:location] || {}

    
    subscription.ip = location[:ip]
    subscription.country = location[:country]
    subscription.country_code = location[:country_code]
    subscription.continent = location[:continent]
    subscription.continent_code = location[:continent_code]
    subscription.asn = location[:asn]
    subscription.as_name = location[:as_name]
    subscription.as_domain = location[:as_domain]
    
        if subscription.save
            subscriber_count = PushSubscription.count
            DashboardStat.find_or_create_by!(id: 1).update!(
                subscriber_count: subscriber_count
                )

            render json: {
                success: true,
                message: "subscription saved",
                subscriber_count: subscriber_count
            },
            status: :created
        else
            render json: {
                success: false,
                errors: subscription.errors.full_messages
            },
            status: :unprocessable_entity
    end
        
    end

    def destroy
        subscription = PushSubscription.find(params[:id])

        subscription.destroy!

        subscriber_count = PushSubscription.count

        DashboardStat.find_or_create_by!(id: 1).update!(
        subscriber_count: subscriber_count
        )

        render json: {
        success: true,
        message: "subscription deleted",
        subscriber_count: subscriber_count
        }
    end
end
