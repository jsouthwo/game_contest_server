class Contest < ActiveRecord::Base
  belongs_to :user
  belongs_to :referee

  has_many :players
  has_many :matches, as: :manager

  validates :deadline,      presence: true, timeliness: {type: :datetime, allow_nil: false, on_or_after: :now, on_or_before: :start}
  validates :start,         presence: true, timeliness: {type: :datetime, allow_nil: false, on_or_after: :now, on_or_after: :deadline }
  validates :description,   presence: true
  validates :name,          presence: true, uniqueness: true
  validates :contest_type,  presence: true
  validates :user,          presence: true
  validates :referee,       presence: true

end
