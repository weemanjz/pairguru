# == Schema Information
#
# Table name: genres
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime
#  updated_at   :datetime
#  movies_count :integer          default(0)
#

class Genre < ApplicationRecord
  has_many :movies
end
