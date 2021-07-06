# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    before_action :require_login
    # before_action :is_admin?

    # def is_admin?
    #   redirect_to root_path unless current_user.has_role?(:admin)
    # end
  end
end
