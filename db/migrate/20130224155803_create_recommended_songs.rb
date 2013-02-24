class CreateRecommendedSongs < ActiveRecord::Migration
  def change
    create_table :recommended_songs do |t|
      t.integer :song_id
      t.integer :recommendation_id

      t.timestamps
    end
  end
end
