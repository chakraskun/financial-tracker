# frozen_string_literal: true

class UtilsController < ApplicationController
  protect_from_forgery except: :service_worker

  def service_worker
    respond_to do |format|
      format.js do
        render file: "public/serviceworker.js", layout: false
      end
    end
  end
end
