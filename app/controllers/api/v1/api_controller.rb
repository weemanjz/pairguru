module Api
  module V1
    class ApiController < ActionController::API
      before_action :ensure_json_request

      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def ensure_json_request
        return if request.format == :json
        render nothing: true, status: :not_acceptable
      end

      def render_not_found
        render json: { message: "Movie not found" }, status: :not_found
      end

      respond_to :json
    end
  end
end
