# frozen_string_literal: true

module RatingChgkV2
  module Rest
    module Countries
      def countries(params = {})
        RatingChgkV2::Collections::CountriesCollection.load :do_get, countries_endpoint([], params)
      end

      def country(id)
        RatingChgkV2::Models::CountryModel.load :do_get, countries_endpoint(id)
      end

      def create_country(params)
        RatingChgkV2::Models::CountryModel.load :do_post, countries_endpoint([], params)
      end

      def update_country(id, params)
        RatingChgkV2::Models::CountryModel.load :do_put, countries_endpoint(id, params)
      end

      def delete_country(id)
        countries_endpoint(id).do_delete
      end

      private

      def countries_endpoint(query, params = {})
        RatingChgkV2::Endpoints::CountriesEndpoint.new self, query, params
      end
    end
  end
end