# frozen_string_literal: true

module Rockstart::Prefab
  class SitemapGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def remove_static_file
      remove_file "public/robots.txt"
    end

    def add_sitemap_gem
      gem "sitemap_generator"
    end

    def add_sitemap_config
      copy_file "sitemap_config.rb", "config/sitemap.rb"
    end

    def add_robots_controller
      copy_file "robots_controller.rb", "app/controllers/robots_controller.rb"
      copy_file "show.text.erb", "app/views/robots/show.text.erb"
      copy_file "robots_spec.rb", "spec/requests/robots_spec.rb"
    end

    def add_robots_route
      route 'get "/robots.:format", to: "robots#show"'
    end

    def add_release_step
      append_to_file "bin/hooks-release", <<~'RELEASE' + "\n"

        FileUtils.chdir APP_ROOT do
          puts "== Generating Sitemap =="
          if ENV["SEO_ENABLED"].present?
            system! "bundle exec rake sitemap:refresh"
          else
            puts "Set environment variable SEO_ENABLED=enabled to enable sitemap"
          end
        end
      RELEASE
    end
  end
end
