# frozen_string_literal: true

require_relative 'connection'
require_relative 'json_handler'
require_relative 'error'

module RatingChgkV2
  module Request
    include RatingChgkV2::Connection
    include RatingChgkV2::JsonHandler

    def get(path, client, params = {})
      respond_with(
        connection(client).get(prepare(path), params),
        client
      )
    end

    private

    # Get rid of double slashes in the `path`, leading and trailing slash
    def prepare(path)
      path.delete_prefix('/').gsub(%r{//}, '/').gsub(%r{/+\z}, '')
    end

    def respond_with(response, _client)
      body = custom_load response.body
      status = response.status
      respond_with_error status, body if status.between?(400, 599)

      body
    end

    def respond_with_error(code, body)
      raise(RatingChgkV2::Error, body) unless RatingChgkV2::Error::ERRORS.key? code

      raise RatingChgkV2::Error::ERRORS[code].from_response(body)
    end
  end
end