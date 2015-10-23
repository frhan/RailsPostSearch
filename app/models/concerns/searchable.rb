module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # Customize the index name
    #
    index_name Rails.application.engine_name
    # Set up index configuration and mapping
    #
    settings index: { number_of_shards: 1, number_of_replicas: 0} do
      mapping do
        indexes :title, type: 'multi_field' do
          indexes :title, analyzer: 'snowball'
          indexes :tokenized, analyzer: 'simple'
        end

        indexes :desc, type: 'multi_field' do
          indexes :desc, analyzer: 'snowball'
          indexes :tokenized, analyzer: 'simple'
        end

        indexes :created_at, type: 'date'
        indexes :price
        indexes :image

        indexes :categories do
          indexes :id
          indexes :name
        end

        indexes :location do
          indexes :id
          indexes :name
        end
      end
    end
    after_touch() { __elasticsearch__.index_document }

    def as_indexed_json(options = {})
      hash = self.as_json(
          include: { categories: { only: [:id,:name] },
                     location: { only: [:id,:name] }
          })
      hash
    end

    def self.search(query, options={})

      __set_filters = lambda do |key, f|

        @search_definition[:filter][:and] ||= []
        @search_definition[:filter][:and]  |= [f]

        @search_definition[:facets][key.to_sym][:facet_filter][:and] ||= []
        @search_definition[:facets][key.to_sym][:facet_filter][:and]  |= [f]
      end
      @search_definition = {
          query: {},
          filter: {},
          facets: {
              categories: {
                  terms: {
                      field: 'categories.name'
                  },
                  facet_filter: {}
              },
              location: {
                  terms: {
                      field: 'location.name'
                  },
                  facet_filter: {

                  }
              }
          }
      }



      if options[:category]
        f = { term: { "categories.name" => options[:category] } }

        __set_filters.(:location, f)

      end

      if options[:location]
        f = { term: { location: options[:location] } }

        __set_filters.(:categories, f)
      end


      unless query.blank?
        @search_definition[:query] = {
            bool: {
                should: [
                    { multi_match: {
                        query: query,
                        fields: ['title^10', 'desc^2'],
                        operator: 'and'
                    }
                    }
                ]
            }
        }
      else
        @search_definition[:query] = { match_all: {} }
        #@search_definition[:sort]  = { published_on: 'desc' }
      end
      puts @search_definition
      __elasticsearch__.search(@search_definition)
    end

  end
end
