class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest

  has_many :matches, through: :player_matches, as: :manager

  validates :contest,   presence: true 
  validates :user,      presence: true 
end
