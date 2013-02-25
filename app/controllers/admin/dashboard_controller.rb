class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    @songs = Song.with_vote_counts.order("vote_counts DESC")
  end
end
