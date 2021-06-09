# frozen_string_literal:true

class SessionsController < Clearance::SessionsController
  include Clearance::Controller
  layout 'session'

  before_action :skip_if_login, except: %i[new destroy_ajax destroy]

  def new; end

  def create
    @user = authenticate(params)
    if @user.nil?
      flash[:danger] = 'Wrong email or password'
      return redirect_back fallback_location: root_path
    end

    run_session_creation
  end

  private
    def run_session_creation
      @user = authenticate(params)

      sign_in(@user) do |status|
        if status.success?
          return redirect_back_or url_after_create
        else
          flash[:danger] = status.failure_message
          return redirect_back_or root_path
        end
      end
    end

    def skip_if_login
      return unless signed_in?
      redirect_to root_path
    end
end
