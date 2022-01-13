# frozen_string_literal: true

module MonthlyPlanLines
  class CreateService < BaseService
    def initialize params
      @params = params
    end

    def action
      @line = MonthlyPlanLine.new(@params)
      binding.pry
      @line.save!
    end

    def line
      return @line
    end

    def errors
      return @line.errors
    end
  end
end
