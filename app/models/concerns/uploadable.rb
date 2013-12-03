module Uploadable
    extend ActiveSupport::Concern

    included do 
        validates :file_location, presence: true
        validate :valid_file_location?
    end

    def valid_file_location?
        errors.add(:file_location, "must be valid") if 
        self.file_location and not (File.exists?(self.file_location) or File.symlink?(self.file_location))
    end

    def upload=(uploaded_io)
#        puts "called upload="
        time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
        if uploaded_io.nil?
            # problem -- deal with later
            puts 'PROBELM === NO UPLOADED_IO'
        else
            file_location = Rails.root.join('code',
                                            self.class.to_s.pluralize.downcase,
                                            Rails.env,
                                            time_no_spaces + SecureRandom.hex
                                           ).to_s
            IO::copy_stream(uploaded_io, file_location)
=begin
            if self.class.to_s.pluralize.downcase == "players"
                puts "FILE_LOCATION:: " + file_location
            end
=end
            self.file_location = file_location
        end
    end

end
