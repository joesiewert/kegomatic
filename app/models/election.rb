class Election < ActiveRecord::Base
  has_many :votes

  def leading_keg
    voted_kegs = []
    votes = Hash.new(0)

    if self.votes.count == 0
      return "No votes yet"
    else
      self.votes.each do |vote|
        voted_kegs << vote.keg_id
      end

      voted_kegs.each do |keg|
        votes[keg] += 1
      end

      leader = votes.max_by{|keg, votes| votes}
      return "#{Keg.find(leader[0]).name} (#{leader[1]} votes)"
    end
  end

end
