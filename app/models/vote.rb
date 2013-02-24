class Vote < ActiveRecord::Base
  attr_accessible :song_id, :user_id, :voted_up

  belongs_to :song
  belongs_to :user

  scope :since, lambda {|time|
    {:conditions => ["created_at >= ?", time.to_s(:db)]}
  }
  scope :vote_ups, :conditions => {:voted_up => true}
  scope :vote_downs, :conditions => {:voted_up => false}
end
