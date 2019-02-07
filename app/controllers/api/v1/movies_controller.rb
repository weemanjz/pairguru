module Api
  module V1
    class MoviesController < ApiController
      def index
        movies = Movie.select(:id, :title, :genre_id)
        movies = movies.includes(:genre) if with_genre?
        render_data movies
      end

      def show
        render_data Movie.find(params[:id])
      end

      private

      def render_data(data)
        render json: data, append_genre_data: with_genre?
      end

      def with_genre?
        params.fetch(:with_genre, "").casecmp?("true")
      end
    end
  end
end
