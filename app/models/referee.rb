require 'securerandom'
class Referee < ActiveRecord::Base
    belongs_to :user

    has_many :contests
    has_many :matches, as: :manager

    include Uploadable
=begin
    def upload=(uploaded_io)
        time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
        # ... code and stuff ...
        #
        if uploaded_io.nil?
            # problem -- deal with later
            'lala'
        else
            file_location = Rails.root.join('code',
                                            'referees',
                                            Rails.env,
                                            time_no_spaces + SecureRandom.hex
                                           ).to_s
            IO::copy_stream(uploaded_io, file_location)
            self.file_location = file_location
        end
    end
=end

    validates :name,                presence: true, uniqueness: true
    validates :rules_url,           presence: true, url: true
# OR format: {with: URI::regexp}
    validates :players_per_game,    presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to:10} 
=begin
    validates :file_location,       presence: true
    validate :valid_file_location?

    def valid_file_location?
        errors.add(:file_location, "must be valid") if 
        self.file_location and not (File.exists?(self.file_location) or File.symlink?(self.file_location))
    end
=end
end
