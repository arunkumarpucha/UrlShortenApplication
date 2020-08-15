class MiniUrlsController < ApplicationController

	def new
		@mini_url = MiniUrl.new
	end

	def create
	  #raise params.inspect
		@mini_url = MiniUrl.new(mini_url_params)
		if @mini_url.save
			@mini_urls = MiniUrl.all.order('created_at DESC')
			# redirect_to mini_urls_path
		else
			flash.now[:error]
			render 'new'
		end
  end

  def report_analytic
  	

  	#raise request.remote_ip.inspect
  	
  	#raise Geocoder.search('123.201.174.253').inspect
  	# raise request.location.inspect
  	# cnt = results.first.country
  	# raise cnt.inspect
  	remote_ip = request.remote_ip
  	results = Geocoder.search(remote_ip)
  	country = results.first.country
  	country = country || "India"
  	mini_url_rec = MiniUrl.find_by(id: params[:mini_url_id])
  	if mini_url_rec.present?
  		url_histories = mini_url_rec.url_histories
  		url_history_count = url_histories.count
  		if (url_history_count == 0)
  			click_count = 1
  		  ip_addresses = [remote_ip]
  		  countries = [country]
  			mini_url_rec.url_histories.create(click_count: click_count,countries: countries,ip_addresses: ip_addresses)
  		else
  			ip_addresses = mini_url_rec.url_histories.first.ip_addresses+[remote_ip]
  			click_count = mini_url_rec.url_histories.first.click_count+1
  			countries = mini_url_rec.url_histories.first.countries+[country]
  			mini_url_rec.url_histories.first.update(click_count: click_count,countries: countries.uniq!,ip_addresses: ip_addresses.uniq!)
  		end
  		redirect_to mini_url_rec.original_url
  	end
  end

  def index
  	@all_urls_list = MiniUrl.all.order('created_at DESC')
  end


  private
  def mini_url_params
  	params[:mini_url].permit(:original_url,:short_url,:sanitize_url)
  end

end
