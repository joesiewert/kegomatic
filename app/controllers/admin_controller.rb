class AdminController < ApplicationController
  def index
    @kegs = Keg.order(:name)
  end
end
