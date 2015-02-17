class Vote < ActiveRecord::Base
  belongs_to :election
  belongs_to :user
  belongs_to :keg
end
