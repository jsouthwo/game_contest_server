class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee

  has_many :players
  has_many :matches, as: :manager

  validates :deadline,      presence: true
  validates :start,         presence: true
  validates :description,   presence: true
  validates :name,          presence: true
  validates :contest_type,  presence: true
  validates :user,          presence: true
  validates :referee,       presence: true
end
