class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :long_url
      t.string :shorty
      t.references :user, index: true, foreign_key: true
      t.integer :visits_count, :default => 0
      t.timestamps null: false
    end
  end
end
