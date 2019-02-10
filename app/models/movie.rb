# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre, counter_cache: true
  has_many :comments

  validates_with TitleBracketsValidator

  def commented_by?(user)
    return comments.map(&:user_id).include?(user.id) if comments.loaded?
    comments.exists?(user_id: user.id)
  end
end
