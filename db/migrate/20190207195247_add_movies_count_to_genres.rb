class AddMoviesCountToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :movies_count, :integer, default: 0
  end
end
