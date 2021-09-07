# frozen_string_literal: true

module Admin
  class ProjectsController < Admin::ApplicationController
    before_action :project, only: %i[show edit download update_document_transaction]

    def index
      @new_project = Project.new
    end

    def show; end
    def edit; end

    def create
      service = ::Projects::CreateService.new(
        project_params,
        current_branch.id,
        current_user.id
      )

      if !service.run
        return redirect_to admin_projects_path,
          alert: "Failed to create project, #{service.error_messages.to_sentence}"
      end
      redirect_to admin_project_path(id: service.projects.id), notice: "Project has been created"
    end

    def destroy
      if !project.destroy

        flash[:danger] = "Failed to delete project. #{project.errors.full_messages.to_sentence}"
        return redirect_to admin_projects_path
      end

      redirect_to admin_projects_path,
        flash: { success: 'Success delete Projects' }
    end


    private
    def project
      @project ||= Project.find_by_id(params[:id])
    end

    def project_params
      @project_params = params.require(:project)
      .permit(
        :name, :description, :date, :due_date, :price
      )
    end
  end
end
