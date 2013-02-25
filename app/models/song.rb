class Song < ActiveRecord::Base
  attr_accessible :name, :attachment, :attachment_file_name, :user_id

  # Associations
  belongs_to :user
  belongs_to :recommendation
  has_many :votes

  # validations
  validates_presence_of :name
  validates_presence_of :attachment_file_name

  has_attached_file :attachment

  scope :with_vote_counts, :select => "*, ((select count(*) from votes v1 where v1.created_at >= IFNULL(songs.last_played_at, songs.created_at) AND v1.song_id = songs.id AND v1.voted_up=1) - 2 * (select count(*) from votes v2 where v2.created_at >= IFNULL(songs.last_played_at, songs.created_at) AND v2.song_id = songs.id AND v2.voted_up=0)) as vote_counts"

  def self.upcoming
    #Song.with_vote_counts.order("vote_counts DESC").delete_if{|s| s.vote_counts < 2}
    songs = Song.all
    return songs.delete_if{|s| s.vote_count < 2}.sort{|a, b| a.vote_count <=> b.vote_count}
  end

  def to_s
    self.name
  end

  def vote_count
    vote_ups = self.votes.since(self.last_played_at || self.created_at).vote_ups.count
    vote_downs = self.votes.since(self.last_played_at || self.created_at).vote_downs.count

    vote_ups - (2*vote_downs)
  end
end
