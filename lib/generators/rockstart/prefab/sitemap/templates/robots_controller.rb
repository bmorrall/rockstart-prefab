# frozen_string_literal: true

class RobotsController < ActionController::Base
  before_action -> { request.session_options[:skip] = true }

  helper_method :seo_enabled?
  helper_method :sitemap_url

  def show
    respond_to :text
    expires_in 6.hours, public: true
  end

  private

  def seo_enabled?
    ENV["SEO_ENABLED"].present?
  end

  def sitemap_url
    if (cloudcube_url = ENV["CLOUDCUBE_URL"].presence)
      public_prefix = Utils::Cloudcube.public_prefix(cloudcube_url)
      URI.join(cloudcube_url, "#{public_prefix}/sitemap.xml.gz").to_s
    else
      URI.join(root_url, "sitemap.xml.gz").to_s
    end
  end
end
