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
    
        if subscription.save
            render json: {
                success: true,
                message: "subscription saved"
            },
            status: :created
        else
            render json: {
                success: false,
                errors: subscription.error.full_messages
            },
            status: :unprocessable_entity
    end
        
    end
end
