class PopulateGenreMoviesCount < ActiveRecord::Migration[5.2]
  def up
    Genre.find_each { |genre| Genre.reset_counters(genre.id, :movies) }
  end
end
