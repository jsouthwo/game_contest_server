class Referee < ActiveRecord::Base
  # means one user to many referees
  belongs_to :user

  has_many :contests
  has_many :matches, as: :manager
end
