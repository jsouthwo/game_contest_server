class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  has_many :matches, through: :player_matches
  has_many :player_matches

  validates :contest,   presence: true 
  validates :user,      presence: true 
end
