# frozen_string_literal: true

module MonthlyPlans
  class BaseService < ::BaseService

    def initialize params, current_user_id
      @params = params
      @current_user = current_user_id
    end

    protected
      def monthly_params
        @monthly_params ||= @params
          .require(:monthly_plan)
          .permit(
            :id,
            :month,
          )
      end

      def monthly_lines_params
        @monthly_lines_params ||= @params.permit(
          monthly_plan_lines: [
            :id,
            :shopping_list_id,
            :price,
            :monthly_plan_id
          ]
        )[:monthly_plan_lines]
      end
  end
end
