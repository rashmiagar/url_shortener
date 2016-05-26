class ShortVisit < ActiveRecord::Base
	belongs_to :short_url, , dependent: :destroy
end
