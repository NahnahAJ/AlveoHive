class WebhooksController < ApplicationController
    # protect_from_forgery with: :null_session
    # TODO: remove the below in production
    skip_before_action :verify_authenticity_token

    ALLOWED_IPS = ['52.31.139.75', '52.49.173.169', '52.214.14.220'].freeze

    def paystack
      # Verify that the request is coming from an allowed IP address
      unless valid_ip?
        Rails.logger.warn('Unauthorized IP Address: Access denied')
        head :unauthorized and return
      end

    # # Validate the event using signature validation
    # if !valid_paystack_signature?

      # Retrieve the request's body
      event = params[:event]
      # Retrieve the data body
      data = params[:data]

      # Log the raw event for debugging purposes
      Rails.logger.info("Paystack Webhook Received: #{event}")

      # Process the event
      handle_paystack_event(event, data)

      # end
  
      head :ok
    end

    private

    def valid_ip?
      remote_ip = request.remote_ip
      ALLOWED_IPS.include?(remote_ip)
    end

    def valid_paystack_signature?
      payload = request.body.read
      signature = request.headers['HTTP_X_PAYSTACK_SIGNATURE']
  
      secret = ENV['PAYSTACK_SECRET_KEY'] # Replace with actual Paystack secret key
      hash = OpenSSL::HMAC.hexdigest('sha512', secret, payload)
  
      if hash == signature
        Rails.logger.info('Paystack Signature Validation: Success')
        return true
      else
        Rails.logger.warn('Paystack Signature Validation: Failed')
        return false
      end
    end

    def handle_paystack_event(event, data)
      # Log the processed event
      Rails.logger.info("Handling Paystack Event: #{event}")

      # Implement logic to handle different Paystack events
      case event
      when 'charge.success'
        # Process successful charge event
        Rails.logger.info('Charge Successful: Processing...')
        # Handle successful charge
        handle_charge_success(data)

      when 'refund.processed'
        # Process refund processed event
        Rails.logger.info('Refund Processed: Processing...')
      # Add more cases for other supported events
      else
        # Handle unsupported events or log them
        Rails.logger.warn("Unsupported Paystack Event: #{event}")
      end
    end

    def handle_charge_success(data)
      reference = data['reference']

      # Find the user by reference in your database
      user_detail = UserDetail.find_by(reference: reference)

      if user_detail
        # Update user subscription details
        user_detail.update(
          subscription: 'subscribed',
          last_subscription_date: Time.now
        )

        Rails.logger.info("Subscription updated for user with reference #{reference}")
      else
        Rails.logger.warn("User not found for reference #{reference}")
      end
    end

  end
  