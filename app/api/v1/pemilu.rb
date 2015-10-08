module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :agendas do
      desc "Return all Agendas"
      get do

        agendas = Array.new

        # Prepare conditions based on params
        valid_params = {
          category: 'category'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Agenda.where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |agenda|
            agendas << {
              id: agenda.id,
              kegiatan: agenda.name,
              jadwal: [
                awal: agenda.start,
                akhir: agenda.finish
              ],
              kategori: agenda.category
            }
        end

        {
          results: {
            count: agendas.count,
            total: Agenda.count,
            agendas: agendas
          }
        }
      end
    end

    resource :categories do
      desc "Return all Category of Agenda"
      get do
        categories = Array.new

        Category.all.each do |category|
          categories << {
            id: category.id,
            nama: category.name
          }
        end

        {
          results: {
            count: categories.count,
            total: Category.count,
            categories: categories
          }
        }
      end
    end
  end
end