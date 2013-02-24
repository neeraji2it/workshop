class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def new
    @song = current_user.songs.new
  end

  def create
    @song = current_user.songs.new(params[:song])

    if @song.save
      redirect_to songs_path
    else
      render :action => :new
    end
  end

  def edit
    @song = current_user.songs.find(params[:id])
  end

  def update
    @song = current_user.songs.find(params[:id])
    if @song.update_attributes(params[:song])
      redirect_to songs_path
    else
      render :action => :edit
    end
  end

  def destroy
    @song = current_user.songs.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  def vote_up
    @song = Song.find(params[:id])
    current_user.vote_up_for(@song)

    redirect_to songs_path
  end

  def vote_down
    @song = Song.find(params[:id])
    current_user.vote_down_for(@song)

    redirect_to songs_path
  end
end
