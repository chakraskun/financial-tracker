# frozen_string_literal: true

module ShoppingLists
  class BaseService < ::BaseService

    def initialize params
      @params = params
    end

    protected
      def list_params
        @list_params ||= @params
          .require(:shopping_list)
          .permit(
            :id,
            :name,
          )
      end
  end
end
