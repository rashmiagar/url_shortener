class ShortUrl < ActiveRecord::Base

	belongs_to :user
	has_many :short_visits, dependent: :destroy


	validates :long_url, presence: true, 
						format: { with: /[^(http|https):\/\/]/ },
            uniqueness: {scope: :user_id}
	validates :shorty, uniqueness: true
	

	HOST_NAME = 'localhost:3000/shortUrl'
	UNIQUE_KEY_LENGTH = 5

 
  def self.generate(orig_url, user=nil)
    uid = user.nil? ? nil : user.id
    sl = ShortUrl.where("user_id = ? and long_url = ?", uid, orig_url).first
    return sl.shortened_url if sl

    begin
      unique_key = self.generate_random_string(UNIQUE_KEY_LENGTH)
    end while ShortUrl.find_by_shorty unique_key

    sl = ShortUrl.create(long_url: orig_url, shorty: unique_key, user: user)

    return sl.shorty
  end
  
  private

   def shortened_url
    # use the url writer to generate the url
    return "http://" + HOST_NAME + "/" + self.shorty
  end

  def self.generate_random_string(size = 6)
    charset = ('a'..'z').to_a + (0..9).to_a
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def generate_slug
    self.shorty = self.id.to_i.to_s(36)
    self.user = @current_user
    self.save
  end
end
