class AddTrackToShortUrls < ActiveRecord::Migration
  def change
  	add_column :short_urls, :track, :boolean, default: false
  end
end
