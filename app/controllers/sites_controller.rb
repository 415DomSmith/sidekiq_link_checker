class SitesController < ApplicationController
  before_action :find_site, only:[:show, :edit, :update, :destroy]

  def index
  	@sites = Site.all
  end

  def new
  	@site = Site.new
  end

  def create

    url = site_params["address"]
    links_arr = find_links(url)

  	@site = Site.new(site_params)
  	if @site.save
  		redirect_to sites_path, flash: {success: "SITE ADDED, CHECKING LINKS"}
  	else 
  		render :new_site, flash: {alert: "FAILED TO ADD NEW SITE"}
  	end
  end

  def edit
  end

  def update
  	@site.update(site_params)
  	if @site.save
  		redirect_to sites_path, flash: {success: "SITE UPDATED"}
  	else
  		render :edit_site, flash: {alert: "FAILED TO UPDATE SITE"}
  	end
  end

  def show
  end

  def destroy
  	@site.destroy
  	redirect_to sites_path, flash: {alert: "SITE REMOVED"}	
  end

  private
  	def find_site
  		@site = Site.find_by_id(params[:id])	
  	end

  	def site_params
  		params.require(:site).permit(:name, :address)
  	end

    def find_links(url)
      response = RestClient.get url, :user_agent => 'Chrome'
      page = Nokogiri::HTML(response)
      links_array = []
      links = page.css('a')
      links.each do |link|
      href = link.attr('href')
      links_array << href
    end
      links_array
    end

end
