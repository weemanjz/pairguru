class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :genre, if: -> { instance_options[:append_genre_data] }
end
