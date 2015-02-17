class Admin::ElectionsController < ApplicationController
  def start
    election = Election.new(active: true)

    if election.save
      redirect_to admin_index_path, notice: 'Election started!'
    else
      render admin_index_path
    end
  end

  def end
    election = Election.find(params[:id])

    if election.update(active: false)
      redirect_to admin_index_path, notice: 'Election ended!'
    else
      render admin_index_path
    end
  end
end
