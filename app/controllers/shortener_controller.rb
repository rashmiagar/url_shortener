

class ShortenerController < ApplicationController
	before_action :get_current_user

	def index
	  @short_urls = @current_user.shortUrls
	end

	def show
	  @short_url = ShortUrl.find_by(shorty: params[:id])
	  @short_url.visits_count += 1
	  @short_url.save
	 
	  # save GEo ip data
	  if @short_url.track
	  	# client_ip = request.remote_ip
	  	@info = request.location
	  	# @info = GeoIP2.new(Rails.root.join('public/GeoIP.dat')).city(client_ip)
	  	@short_visit = ShortVisit.new
	  	@short_visit.visitor_ip =  @info.ip
	  	@short_visit.visitor_city = @info.city
	  	@short_visit.visitor_country_iso2 = @info.country_code
	    @short_visit.visitor_state = @info.data[:region_name]
	  	@short_visit.short_url = @short_url
	  	@short_visit.save
	  	puts @info.inspect
	  	# byebug
	  end
	  respond_to do |format|
	  	format.html{redirect_to @short_url.long_url}
	  end
	end
	
	def new
	  @short_url = ShortUrl.new
	  respond_to do |format|
	  	format.html
	  end
	end

	def create
	  ShortUrl.generate(short_url_params[:long_url], @current_user)
      redirect_to action: 'index'
    end
	
	def delete
	  short_url = ShortUrl.find(params[:id])
	  short_url.delete
	  render action: 'index'
	end
	def update
	  ShortUrl.find(params[:id]).update(track: params[:track])
	end

	private
	  def get_current_user
	  	@current_user = current_user
	  end
	  def short_url_params
	  	params.require(:short_url).permit(:long_url, :track)
	  end
end
