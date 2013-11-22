require 'securerandom'
class Player < ActiveRecord::Base
    belongs_to :user
    belongs_to :contest

    has_many :matches, through: :player_matches
    has_many :player_matches

    def upload=(uploaded_io)
        time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
        # ... code and stuff ...
        #
        if uploaded_io.nil?
            # problem -- deal with later
            'lala'
        else
            file_location = Rails.root.join('code',
                                            'players',
                                            Rails.env,
                                            time_no_spaces + SecureRandom.hex
                                           ).to_s
            IO::copy_stream(uploaded_io, file_location)
            self.file_location = file_location
        end
    end

    validates :description,     presence: true
    validates :name,            presence: true, uniqueness: true
    validates :contest,         presence: true 
    validates :user,            presence: true 
    validates :file_location,   presence: true
    validate  :valid_file_location?

    def valid_file_location?
        errors.add(:file_location, "must be valid") if 
        self.file_location and not (File.exists?(self.file_location) or File.symlink?(self.file_location)) 
    end
end
