module Api
  module Admin
    module MonthlyPlanLines
      class IndexController < Api::ApplicationController
        def show
          render json: result
        end

        private
        def result
          {
            meta: meta,
            data: data
          }
        end

        def monthly_plan_lines
          return @monthly_plan_lines if @monthly_plan_lines.present?

          list = Invoice.where(
            monthly_plan_id: params[:id],
            shopping_list_id: params[:shopping_list_id]
          )
          @monthly_plan_lines = Kaminari.paginate_array(list)
          @monthly_plan_lines
        end

        def paginated_monthly_plan_lines
          @paginated_monthly_plan_lines ||= monthly_plan_lines
            .page(page[:page])
            .per(page[:perpage])
        end

        def sort
          params[:sort]
        end

        def query
          params[:query]
        end

        def page
          params.require(:pagination)
        end

        def meta
          {
            page: page[:page],
            pages: paginated_monthly_plan_lines.total_pages,
            perpage: page[:perpage],
            total: monthly_plan_lines.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_monthly_plan_lines.each_with_index do |line, index|
            i = index + start_index
            @data[i] = {
              index: i,
              description: line.description,
              created_at: readable_date_2(line.created_at)
            }
          end

          @data
        end

        def start_index
          if page[:page].to_i <= 1
            return 1
          end

          ((page[:page].to_i - 1) * page[:perpage].to_i) + 1
        end
      end
    end
  end
end
