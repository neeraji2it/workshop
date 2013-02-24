class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  # Associations
  has_many :songs
  has_many :recommendations
  has_many :votes

  def to_s
    return self.name if self.name.present?
    return self.email
  end

  def vote_for(song)
    song = Song.find(song) unless song.is_a?(Song)
    return self.votes.since(song.last_played_at || song.created_at).find_by_song_id(song.id)
  end

  def vote_up_for(song)
    song = Song.find(song) unless song.is_a?(Song)

    vote = self.votes.since(song.last_played_at || song.created_at).find_by_song_id(song.id)
    if vote.present?
      vote.voted_up = true
      vote.save
    else
      self.votes.create(:song_id => song.id, :voted_up => true)
    end
  end

  def vote_down_for(song)
    song = Song.find(song) unless song.is_a?(Song)

    vote = self.votes.since(song.last_played_at || song.created_at).find_by_song_id(song.id)
    if vote.present?
      vote.voted_up = false
      vote.save
    else
      self.votes.create(:song_id => song.id, :voted_up => false)
    end
  end

  def has_voted_up_for?(song)
    song = Song.find(song) unless song.is_a?(Song)

    vote = self.votes.since(song.last_played_at || song.created_at).find_by_song_id(song.id)
    if vote.present?
      return vote.voted_up?
    else
      return false
    end
  end
end
