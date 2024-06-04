require 'rest-client'

class PaymentsController < ApplicationController
  # TODO: remove the below in production
  skip_before_action :verify_authenticity_token
    # POST /payments/success
    def success
      user_id = params[:user_id] # with user_id as a parameter
      user_detail = UserDetail.find_by(user_id: user_id)

      if user_detail
        update_subscription(user_detail)
        send_payment_confirmation_email(user_detail)
        render json: { message: 'Payment successful' }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end

    # POST /payments/mobile_money
    def mobile_money
      amount = params[:amount]
      email = params[:email]
      mobile_money_params = params[:mobile_money] || params[:payment][:mobile_money]
      phone = mobile_money_params[:phone]
      provider = mobile_money_params[:provider]
    
      # # Debug output
      # puts "Amount: #{amount}"
      # puts "Email: #{email}"
      # puts "Phone: #{phone}"
      # puts "Provider: #{provider}"
    
      # Validate presence of required parameters
      unless amount.present? && email.present? && phone.present? && provider.present?
        render json: { error: 'Missing required parameters' }, status: :bad_request and return
      end
    
      # Create a charge for mobile money
      charge_response = create_mobile_money_charge(amount, email, phone, provider)
    

      if charge_response['status']
        # Handle different charge statuses
        case charge_response['data']['status']
        when 'pay_offline'
          render json: { message: 'Charge attempted', status: true, data: charge_response['data'] }
        when 'send_otp'
          handle_send_otp_response(provider, charge_response['data'])
        when 'success'
          render json: { message: 'Charge successful', status: true, data: charge_response['data'] }
        when 'pending'
          render json: { message: 'Charge pending', status: true, data: charge_response['data'] }
        else
          render json: { error: 'Unsupported charge status' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Charge creation failed', message: charge_response['message'] }, status: :unprocessable_entity
      end
    end

    # POST /payments/submit_otp
    def submit_otp
      otp = params[:otp]
      reference = params[:reference]

      # Validate presence of required parameters
      unless otp.present? #&& reference.present?
        render json: { error: 'Missing required parameters' }, status: :bad_request and return
      end

      # Submit OTP to Paystack
      otp_response = submit_otp_to_paystack(otp, reference)

      if otp_response['status']
        # Handle different OTP submission statuses
        case otp_response['data']['status']
        when 'success'
          render json: { message: 'Charge successful', status: true, data: otp_response['data'] }
        when 'pending'
          render json: { message: 'Charge pending', status: true, data: otp_response['data'] }
        else
          render json: { error: 'Unsupported OTP submission status' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'OTP submission failed', message: otp_response['message'] }, status: :unprocessable_entity
      end
    end

    # POST /payments/update_user_reference/:id
    def update_user_reference
      user_id = params[:id]
      reference = params[:reference]
  
      user = User.find_by(id: user_id)
  
      if user.present?
        user_detail = user.user_detail || user.build_user_detail
        user_detail.update(reference: reference)
  
        render json: { message: 'Reference updated successfully', status: true }
      else
        render json: { message: 'User not found', status: false }
      end
    end


    private
  
    def update_subscription(user_detail)
      user_detail.update(subscription: 'subscribed', last_subscription_date: Time.current)
    end
  
    def send_payment_confirmation_email(user_detail)
      # Implement your email sending logic here
      # You can use a library like ActionMailer to send emails
    end

    def handle_send_otp_response(provider, data)
      case provider
      when 'mtn', 'atl' # Adjust the provider codes accordingly
        render json: { message: 'Charge attempted', status: true, data: data }
      when 'vod'
        render json: { message: 'Charge attempted', status: true, data: data, instructions: 'Dial *110# to generate a voucher code. Then input the voucher.' }
      else
        render json: { error: 'Unsupported provider for send_otp status' }, status: :unprocessable_entity
      end
    end

    def create_mobile_money_charge(amount, email, phone, provider)
      secret_key = ENV['PAYSTACK_SECRET_KEY']
      url = 'https://api.paystack.co/charge'

      payload = {
        amount: amount,
        email: email,
        currency: 'GHS',
        mobile_money: {
          phone: phone,
          provider: provider
        }
      }

      headers = {
        'Authorization' => "Bearer #{secret_key}",
        'Content-Type' => 'application/json'
      }

      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      JSON.parse(e.response.body)
    end

    def submit_otp_to_paystack(otp, reference)
      secret_key = ENV['PAYSTACK_SECRET_KEY']
      url = 'https://api.paystack.co/charge/submit_otp'
  
      payload = {
        otp: otp,
        reference: reference
      }
  
      headers = {
        'Authorization' => "Bearer #{secret_key}",
        'Content-Type' => 'application/json'
      }
  
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      JSON.parse(e.response.body)
    end

  end
  