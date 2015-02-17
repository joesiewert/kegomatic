class ElectionsController < ApplicationController
  def index
    @election = Election.first
    @vote = Vote.new
  end
end
