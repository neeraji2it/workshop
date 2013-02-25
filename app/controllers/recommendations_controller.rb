class RecommendationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @recommendations = Recommendation.all
  end

  def new
    @recommendation = current_user.recommendations.new
  end

  def create
    @recommendation = current_user.recommendations.new(params[:recommendation])
    if @recommendation.save
      params[:songs].each do |song_id, selection|
        if selection.to_s == "1"
          @recommendation.add(song_id)
        else
          @recommendation.remove(song_id)
        end
      end
      redirect_to recommendations_path
    else
      render :action => :new
    end
  end

  def edit
    @recommendation = current_user.recommendations.find(params[:id])
  end

  def update
    @recommendation = current_user.recommendations.find(params[:id])
    if @recommendation.update_attributes(params[:recommendation])
      params[:songs].each do |song_id, selection|
        if selection.to_s == "1"
          @recommendation.add(song_id)
        else
          @recommendation.remove(song_id)
        end
      end
      redirect_to recommendations_path
    else
      render :action => :edit
    end
  end

  def destroy
    @recommendation = current_user.recommendations.find(params[:id])
    @recommendation.destroy

    redirect_to recommendations_path
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    @songs = @recommendation.songs
  end
end
