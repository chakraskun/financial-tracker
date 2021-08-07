# frozen_string_literal: true

module Admin
  class ProjectsController < Admin::ApplicationController
    before_action :project, only: %i[show edit download update_document_transaction]

    def index
      @new_project = Project.new
      # @start_date = Project.order(date: :asc).first.date.localtime.strftime('%d/%m/%Y')
      # @end_date = Project.order(date: :desc).first.date.localtime.strftime('%d/%m/%Y')
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

    # def get_shipper_info
    #   shipper = Shipper.find_by(name: params[:name])
    #   default_origin = DomesticCity.find_by(city: current_user.branch.origin).alpha3_code

    #   if !shipper.present?
    #     return render json: {
    #       email: "",
    #       address: "",
    #       zip_code: "",
    #       origin: default_origin,
    #       phone_number: "",
    #       is_present: shipper.present?
    #     }
    #   end

    #   render json: {
    #     email: shipper.email,
    #     address: shipper.address,
    #     zip_code: shipper.zip_code,
    #     origin: shipper.origin,
    #     phone_number: shipper.phone_number,
    #     is_present: shipper.present?
    #   }
    # end

    # def show_destination_list
    #   @international = ISO3166::Country.all.map {|f| [f.alpha3,f.name]}
    #   @domestic = DomesticCity.all.map {|f| [f.alpha3_code,f.city]}

    #   if params["type"] == 'domestic'
    #     render json: {
    #       dropdown_html: render_to_string(
    #         partial: 'admin/shipments/partial/dropdown_destination',
    #         locals: {dropdown_list: @domestic}
    #       )
    #     }
    #   else
    #     render json: {
    #       dropdown_html: render_to_string(
    #         partial: 'admin/shipments/partial/dropdown_destination',
    #         locals: {dropdown_list: @international}
    #       )
    #     }
    #   end
    # end

    private
    def project
      @project ||= Project.find_by_id(params[:id])
    end

    def project_params
      @project_params = params.require(:project)
      .permit(
        :name, :description, :date, :due_date, :price
      )

      # @shipment_params[:name] = params[:shipper_name][:title] + " " + params[:shipper_name][:name]
      # @shipment_params[:shipment_insurance] = params[:insurance].permit(:type, :company_name).to_h
      # @shipment_params[:consignee_customer_type] = params[:consignee_customer].permit(:type, :company_name).to_h
      # @shipment_params[:item_dimension] = params[:dimension].permit(:height, :width, :depth).to_h
      # @shipment_params[:consignee_address] = params[:full_address].permit(:consignee_full_address, :zip_code, :area, :destination).to_h
      # @shipment_params
    end
  end
end
