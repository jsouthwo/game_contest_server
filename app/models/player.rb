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
    # TODO: THIS SHOULD BE DONE BETTER
    validates :file_location,   presence: true, format: { with: /code\/players\/*/ }
#    validates :file_location,   valid_file_location: true

=begin
    def valid_file_location?
        errors.add(:file_location, "must be valid") unless
        File.exists?(:file_location.to_s) or File.symlink?(:file_location.to_s)
        #!expiration_date.blank? and expiration_date < Date.today
    end


    class ValidFileLocationValidator
        def validate
            errors.add(:file_location, "must be valid") unless
            File.exists?(:file_location.to_s) or File.symlink?(:file_location.to_s)
        #!expiration_date.blank? and expiration_date < Date.today
        end
    end
=end
end
