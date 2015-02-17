class Admin::ElectionsController < ApplicationController
  def create
    election = Election.new(active: true)

    if election.save
      redirect_to admin_index_path, notice: 'Election created and taking votes!'
    else
      render admin_index_path
    end
  end
end
