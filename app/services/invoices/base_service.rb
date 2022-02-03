# frozen_string_literal: true

module Invoices
  class BaseService < ::BaseService

    def initialize params, current_user_id
      @params = params
      @current_user = current_user_id
    end

    protected
      def invoice_params
        @invoice_params ||= @params
          .require(:invoice)
          .permit(
            :id,
            :invoice_type,
            :description,
            :price,
            :date,
            :monthly_plan_id,
            :shopping_list_id,
            :proof_of_transaction
          )
      end
  end
end
