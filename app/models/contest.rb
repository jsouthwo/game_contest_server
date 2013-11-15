class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee

  has_many :players
  has_many :matches, as: :manager

  validates_datetime :start, allow_nil: false#,         presence: true
  #validates :start,         presence: true
  validates_datetime :deadline, allow_nil: false#,         presence: true
  #validates :deadline,         presence: true
  validates :description,   presence: true
  validates :name,          presence: true
  validates :contest_type,  presence: true
  validates :user,          presence: true
  validates :referee,       presence: true

end
