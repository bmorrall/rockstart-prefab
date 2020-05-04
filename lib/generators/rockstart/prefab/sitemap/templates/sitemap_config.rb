# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = URI.parse("https://" + ENV["APP_HOST"]).to_s

if ENV["CLOUDCUBE_ACCESS_KEY_ID"].present?
  require "aws-sdk-s3"

  cloudcube_url = ENV.fetch("CLOUDCUBE_URL")
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
    Utils::Cloudcube.bucket(cloudcube_url),
    aws_access_key_id: ENV["CLOUDCUBE_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV.fetch("CLOUDCUBE_SECRET_ACCESS_KEY"),
    aws_region: Utils::Cloudcube.region(cloudcube_url)
  )
  SitemapGenerator::Sitemap.sitemaps_host = File.join(cloudcube_url, "public")
  SitemapGenerator::Sitemap.sitemaps_path = Utils::Cloudcube.public_prefix(cloudcube_url)
end

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
