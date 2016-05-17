# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string
#  host       :string
#  subdomain  :string
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SitesController < ApplicationController
  before_filter :find_site_subdomain_custom_domain
  before_action :find_site



  def show
  end

  def edit
  end

  private

  def find_site
    @site = Site.find_by_subdomain(request.host.split('.').first)
  end

  def find_site_subdomain_custom_domain
    case request.host
    when "www.#{Setting.host}", Setting.host, nil
    else
      if request.host.index(Setting.host)
        @current_site = Site.find_by_subdomain(request.host.split('.').first)
      else
        @current_site = Site.find_by_fqdn(request.host)
      end

      if !@current_site
        render :file => "#{Rails.root}/public/404.html",  :status => 404

      end
    end
  end


end
