class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.integer :title_id
      t.string :title
      t.string :original_title
      t.integer :release_year

      t.timestamps
    end
  end
end
