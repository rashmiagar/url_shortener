class Api::ShortenerController < Api::BaseController
  skip_before_filter :verify_autheticity_token

  before_action :authenticate_user!

  respond_to :json

  def index
	  short_urls = @current_user.short_urls
  	render json: short_urls, serializer: ShortUrlSerializer
  end
  
  def create
  	hash = ActiveSupport::HashWithIndifferentAccess.new(short_url_params)  # TODO: handle missing params
    @short_url = ShortUrl.new(hash)
    @short_url.shorty = @short_url.id.to_i.to_s(36)
    @short_url.user = @current_user

    if @short_url.save 
	    render json: {success: true}
    else 
	    render json: {success: false, message: @short_url.errors.full_messages}
    end
  end

	def destroy
	  short_url = ShortUrl.find(params[:id])  # TODO: exception handling
	  short_url.delete
	  render json: {success: true}
	end

	def track
		if params[:url].present?
			url = ShortUrl.find_by(shorty: short_url_params[:url])
			if url
				url.update(track: true)
	    	render json: {success: true, message: "Tracking url"}
	    else
	    	render json: {success: false, message: "Invalid url"}
	    end
	  else
	  	render json: {success: false, message: "Missing url"}
	  end
	end
	def untrack
		if params.present?
		  url = ShortUrl.find_by(shorty: short_url_params[:url])
		  if url
		    url.update(track: false)
		    render json: {success: true, message: "Untracking url"}
	    else
	    	render json: {success: false, message: "Invalid url"}
	    end
	  else
	  	render json: {success: false, message: "Missing url"}
	  end
	end

 private
	def short_url_params
	  	params.require(:short_url).permit(:url, :long_url)
	  end
end