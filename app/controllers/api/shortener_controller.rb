require 'geoip'

class Api::ShortenerController
  before_action :authenticate

  def index
	short_urls = @current_user.shortUrls
  	render json: short_urls.to_json
  end
  def create
	  @short_url = ShortUrl.new(short_url_params)
	  respond_to do |format|
      @short_url.shorty = @short_url.id.to_i.to_s(36)
      @short_url.user = @current_user
      if @short_url.save 
	  	render json: {success: true}
	  else 
	  	render json: {success: false}
	  } 
	  end
  end
	def delete
	  short_url = ShortUrl.find(params[:id])
	  short_url.delete
	  render json: {success: true}
	end


	def track
	  ShortUrl.find_by(shorty: params[:url]).update(track: true)
	  render json: {success: true, message: ""}
	end
	def untrack
		ShortUrl.find_by(shorty: params[:url]).update(track: false)
		render json: {success: true, message: ""}
	end

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.find_by(api_token: token)
      end
    end
end