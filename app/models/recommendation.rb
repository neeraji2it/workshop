class Recommendation < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :recommended_songs
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :user_id

  def to_s
    self.name
  end

  def find_recommended_song(song)
    self.recommended_songs.find_by_song_id(song.is_a?(Song) ? song.id : song).present?
  end

  def is_present?(song)
    self.find_recommended_song(song).present?
  end

  def add(song)
    r = self.find_recommended_song(song)

    unless r.present?
      r = self.recommended_songs.create(:song_id => (song.is_a?(Song) ? song.id : song))
    end

    return r
  end

  def remove(song)
    r = self.find_recommended_song(song)

    if r.present?
      r.destroy
    end

    return r
  end
end
