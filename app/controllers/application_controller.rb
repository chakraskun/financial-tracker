class ApplicationController < ActionController::Base
  include Clearance::Controller

  def sign_in(user)
    user.reset_remember_token! if user
    super
  end
end
