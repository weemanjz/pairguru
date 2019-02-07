class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :movies_count

  def movies_count
    object.movies.size
  end
end
