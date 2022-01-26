# frozen_string_literal: true

module Admin
  class ShoppingListsController < Admin::ApplicationController
    def index
      @total_categories = ShoppingList.count
      @new_list = ShoppingList.new
    end

    def create
      service = ::ShoppingLists::CreateService.new(
        params
      )
      if !service.run
        return redirect_to admin_shopping_lists_path,
          alert: "Failed to create shopping list, #{service.error_messages.to_sentence}"
      end
      redirect_to admin_shopping_lists_path, notice: "Shopping List has been created"
    end
  end
end
