class AdminController < ApplicationController
  def index
    @kegs = Keg.where(active: true).order(:name)
  end
end
