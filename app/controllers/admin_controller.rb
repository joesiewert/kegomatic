class AdminController < ApplicationController
  def index
    @kegs = Keg.where(active: true).order(:name)
    @current_elections = Election.where(active: true).order(created_at: :desc)
  end
end
