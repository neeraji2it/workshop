class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :attachment_file_name
      t.integer :user_id
      t.datetime :last_played_at

      t.timestamps
    end
  end
end
