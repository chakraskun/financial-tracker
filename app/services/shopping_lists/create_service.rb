# frozen_string_literal: true

module ShoppingLists
  class CreateService < ::ShoppingLists::BaseService

    def action
      list.save!
    end

    def list
      @list ||= ShoppingList.new(list_params)
    end
  end
end
