module Api
  module Admin
    module ShoppingLists
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

        def shopping_lists
          return @shopping_lists if @shopping_lists.present?

          @shopping_lists = Kaminari.paginate_array(ShoppingList.all)
          @shopping_lists
        end

        def paginated_shopping_lists
          @paginated_shopping_lists ||= shopping_lists
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
            pages: paginated_shopping_lists.total_pages,
            perpage: page[:perpage],
            total: shopping_lists.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_shopping_lists.each_with_index do |list, index|
            i = index + start_index
            @data[i] = {
              index: i,
              name: list.name,
              created_at: readable_date_2(list.created_at)
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
