class CreateShortVisits < ActiveRecord::Migration
  def change
    create_table :short_visits do |t|
      t.references :short_url, foreign_key: true
      t.string :visitor_ip
      t.string :visitor_city
      t.string :visitor_state
      t.string :visitor_country_iso2
      t.timestamps null: false
    end
  end
end
