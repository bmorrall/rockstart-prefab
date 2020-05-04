# frozen_string_literal: true

module Rockstart::Prefab
  class SitemapGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def add_sitemap_gem
      gem "sitemap_generator"
    end

    def add_sitemap_config
      copy_file "sitemap_config.rb", "config/sitemap.rb"
    end

    def add_release_step
      append_to_file "bin/hooks-release", <<~'RELEASE' + "\n"

        FileUtils.chdir APP_ROOT do
          puts "== Generating Sitemap =="
          system! "bundle exec rake sitemap:release"
        end
      RELEASE
    end
  end
end
