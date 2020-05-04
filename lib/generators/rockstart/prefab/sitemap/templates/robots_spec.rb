# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Robots", type: :request do
  describe "GET /robots.txt" do
    context "with a CLOUDCUBE_URL ENV variable" do
      around do |example|
        with_modified_env "CLOUDCUBE_URL" => "https://cloud-cube.s3.amazonaws.com/mycube", "SEO_ENABLED" => "1" do
          example.run
        end
      end

      it "renders a robot.txt with a sitemap" do
        get "/robots.txt"

        expect(response.body).to include("Allow: /")
        expect(response.body).to include("Sitemap: https://cloud-cube.s3.amazonaws.com/mycube/public/sitemap.xml.gz")
      end

      it "sets public cache headers in the reponse" do
        get "/robots.txt"

        expect(response.headers["Cache-Control"]).to eq "max-age=#{6.hours.to_i}, public"
      end

      it "does not attempt to set a cookie for authenticated users" do
        sign_in create(:user)

        get "/robots.txt"

        expect(response.headers.keys).to_not include("Set-Cookie")
      end
    end

    context "with no CLOUDCUBE_URL ENV variable" do
      around do |example|
        with_modified_env "CLOUDCUBE_URL" => "", "SEO_ENABLED" => "1" do
          example.run
        end
      end

      it "includes a Sitemap link to the targeted URL" do
        get "/robots.txt"

        expect(response.body).to include("Sitemap: http://www.example.com/sitemap.xml.gz")
      end
    end

    context "with a SEO Disabled" do
      around do |example|
        with_modified_env "SEO_ENABLED" => "", "CLOUDCUBE_URL" => "https://cloud-cube.s3.amazonaws.com/mycube" do
          example.run
        end
      end

      it "does not allow any remote tracking" do
        get "/robots.txt"

        expect(response.body).to include("Disallow: /")
        expect(response.body).not_to include("Sitemap:")
      end

      it "sets public cache headers in the reponse" do
        get "/robots.txt"

        expect(response.headers["Cache-Control"]).to eq "max-age=#{6.hours.to_i}, public"
      end

      it "does not attempt to set a cookie for authenticated users" do
        sign_in create(:user)

        get "/robots.txt"

        expect(response.headers.keys).to_not include("Set-Cookie")
      end
    end
  end
end
