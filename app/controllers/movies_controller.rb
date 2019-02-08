class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info, :export]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end

  def send_info
    movie = Movie.find(params[:id])
    MovieInfoSender.perform_async(current_user.id, movie.id)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    CsvExportWorker.perform_async(current_user.id, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
