class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    #@songs = Song.with_vote_counts.order("vote_counts DESC")
    @songs = Song.all.sort{|a, b| a.vote_count <=> b.vote_count}
  end
end
