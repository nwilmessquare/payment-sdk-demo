module Api 
  class PaymentsController < ApplicationController
    before_action :user_required

    def create

      @catalog_item = CatalogItem.find(payment_params[:itemId])

      client = Square::Client.new(
        access_token: Rails.application.credentials.payment_sdk.access_token,
        environment: 'sandbox'
      )

      payment_body = {
        source_id: payment_params[:sourceId],
        idempotency_key: "#{payment_params[:sourceId]}:#{payment_params[:itemId]}",
        amount_money: {
          amount: @catalog_item.amount_cents,
          currency: 'USD',
        }
      }
      
      result = client.payments.create_payment(body: payment_body)
      
      if result.success?
        Purchase.create!(user: @user, 
          catalog_item: @catalog_item, 
          token: payment_params[:sourceId],
          payment_id: result.data.payment[:id],
          payment_status: result.data.payment[:status])
        render json: result.data.payment, status: :ok
      elsif result.error?
        render json: result.errors, status: :bad_request
      end
    end

    private
    def payment_params
      @_payment_params ||= params.require(:payment).permit(:locationId, :sourceId, :itemId)
    end
  end
end
