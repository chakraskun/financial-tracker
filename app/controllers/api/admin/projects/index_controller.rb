module Api
  module Admin
    module Projects
      class IndexController < Api::ApplicationController
        def show
          render json: result
        end

        private
        def result
          {
            meta: meta,
            data: data
          }
        end

        def projects
          return @projects if @projects.present?

          @projects = Project.all
            
          if sort.present?
            @projects = @projects
              .order("#{sort[:field]}": sort[:sort])
          end
          @projects = @projects
            .order(date: :desc)

          if query.present?
            apply_filter_from_query
          end

          @projects
        end

        def apply_filter_from_query
          if query.dig(:search).present?
            @projects = @projects
              .search(query[:search])
          end
          # if query.dig(:shipper_id).present? && query.dig(:shipper_id) != 'all'
          #   @projects = @projects
          #     .where(shipper_id: query[:shipper_id])
          # end
          # if query.dig(:destination_type).present? && query.dig(:destination_type) != 'all'
          #   @projects = @projects
          #     .where(shipment_destination_type: query[:destination_type])
          # end
          if query.dig(:daterange).present?
            daterange = query[:daterange].split(' - ')
            start_date = Date.strptime(daterange[0], '%d/%m/%Y')
            end_date  = Date.strptime(daterange[1], '%d/%m/%Y')
            @projects = @projects
              .where('date::date BETWEEN ? AND ?', start_date, end_date)
          end
        end

        def paginated_projects
          @paginated_projects ||= projects
            .page(page[:page])
            .per(page[:perpage])
        end

        def sort
          params[:sort]
        end

        def query
          params[:query]
        end

        def page
          params.require(:pagination)
        end

        def meta
          {
            page: page[:page],
            pages: paginated_projects.total_pages,
            perpage: page[:perpage],
            total: projects.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_projects.each_with_index do |project, index|
            i = index + start_index
            @data[i] = {
              index: i,
              name: project.name,
              description: project.description,
              date: project.date,
              due_date: project.due_date,
              price: project.price&.format,
              
              show_path: admin_project_path(id: project.id),
              delete_path: admin_project_path(id: project.id)
            }
          end

          @data
        end

        def start_index
          if page[:page].to_i <= 1
            return 1
          end

          ((page[:page].to_i - 1) * page[:perpage].to_i) + 1
        end
      end
    end
  end
end
