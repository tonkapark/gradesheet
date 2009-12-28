class Settings::SiteDefaultsController < ApplicationController
  def index
    @defaults = StaticData.defaults
  end

  def update_multiple
    @defaults = StaticData.find(params[:default_ids])
    @defaults.each do |default|
      default.update_attributes!(params[:default].reject { |k,v| v.blank? })
    end
    flash[:notice] = "Updated static defaults!"
    redirect_to site_defaults_path    

  end
end
