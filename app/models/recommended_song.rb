class RecommendedSong < ActiveRecord::Base
  attr_accessible :recommendation_id, :song_id

  belongs_to :recommendation
  belongs_to :song
end
