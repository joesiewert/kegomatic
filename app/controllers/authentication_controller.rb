class AuthenticationController < ApplicationController
  def new
    scraper = Scraper.new
    @kegs = scraper.get_kegs
  end
end
