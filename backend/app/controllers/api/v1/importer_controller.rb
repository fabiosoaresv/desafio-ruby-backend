# frozen_string_literal: true

module Api::V1
  class ImporterController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :importer_params

    # POST api/v1/importer/import_file
    def import_file
      key_file = params.keys.reject { |x| ['action', 'controller'].include?(x) }&.first
      path = params[key_file]&.path

      return default_error unless path.present?

      importer = Importer.new(path)

      if importer.import_and_create_data
        render json: { success: true, message: 'Upload and creation data make with successful!' }
      else
        default_error
      end
    end

    private

    def default_error
      render json: { success: false, message: 'Something is wrong!' }
    end

    def importer_params
      params.permit(:id)
    end
  end
end
