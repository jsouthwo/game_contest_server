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
        else
            file_location = Rails.root.join('code',
                                            'referees',
                                            time_no_spaces + current_user.id.to_s
                                           )
            self.file_location = 'the final location on the server'
        end
    end

    validates :name               presence: true
    validates :rules_url          presence: true
    validates :players_per_game   presence: true
    validates :upload,            presence: true
end
