class Referee < ActiveRecord::Base
    # means one user to many referees
    belongs_to :user

    has_many :contests
    has_many :matches, as: :manager

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
                                            time_no_spaces# + current_user.id.to_s
                                           ).to_s
            IO::copy_stream(uploaded_io, file_location)
            self.file_location = file_location
        end
    end

    validates :name,                presence: true, uniqueness: true
    validates :rules_url,           presence: true
        #, format: /https\://([\w-]+\.)+[\w-]+([w- ./?%\&\=]*)?/i
    validates :players_per_game,    presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to:10} 
    validates :file_location,       presence: true
end
