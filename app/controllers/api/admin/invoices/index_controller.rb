module Api
  module Admin
    module Invoices
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

        def invoices
          return @invoices if @invoices.present?

          @invoices = Invoice
            .all
            .order(date: :desc)            
          if sort.present?
            @invoices = @invoices
              .order("#{sort[:field]}": sort[:sort])
          end
          if query.present?
            apply_filter_from_query
          end
          @invoices
        end

        def apply_filter_from_query
          if query.dig(:search).present?
            @invoices = @invoices
              .search(query[:search])
          end
          # if query.dig(:shipper_id).present? && query.dig(:shipper_id) != 'all'
          #   @invoices = @invoices
          #     .where(shipper_id: query[:shipper_id])
          # end
          # if query.dig(:destination_type).present? && query.dig(:destination_type) != 'all'
          #   @invoices = @invoices
          #     .where(shipment_destination_type: query[:destination_type])
          # end
          # if query.dig(:daterange).present?
          #   daterange = query[:daterange].split(' - ')
          #   start_date = Date.strptime(daterange[0], '%d/%m/%Y')
          #   end_date  = Date.strptime(daterange[1], '%d/%m/%Y')
          #   @invoices = @invoices
          #     .where('date::date BETWEEN ? AND ?', start_date, end_date)
          # end
        end

        def paginated_invoices
          @paginated_invoices ||= invoices
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
            pages: paginated_invoices.total_pages,
            perpage: page[:perpage],
            total: invoices.count
          }
        end

        def data
          return @data if @data.present?

          @data = {}
          paginated_invoices.each_with_index do |invoice, index|
            i = index + start_index
            @data[i] = {
              index: i,
              name: invoice.name,
              description: invoice.description,
              date: readable_date_2(invoice.date),
              price: invoice.price&.format,
              
              show_path: admin_invoice_path(id: invoice.id),
              delete_path: admin_invoice_path(id: invoice.id)
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