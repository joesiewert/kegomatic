class VotesController < ApplicationController
  before_action :set_election

  def create
    vote = Vote.new(vote_params)
    vote.election = @election
    vote.user = current_user

    if vote.save
      redirect_to root_path, notice: "Vote cast for #{vote.keg.name}!"
    else
      redirect_to root_path
    end
  end

  private
    def set_election
      @election = Election.find(params[:election_id])
    end

    def vote_params
      params.require(:vote).permit(:keg_id)
    end
end
