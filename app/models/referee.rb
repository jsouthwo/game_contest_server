require 'securerandom'
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
                                            time_no_spaces + SecureRandom.hex
                                           ).to_s
            IO::copy_stream(uploaded_io, file_location)
            self.file_location = file_location
        end
    end

#    url =~ /^#{URI::regexp}$/

    validates :name,                presence: true, uniqueness: true
    validates :rules_url,           presence: true, url: true
        #, :format => URI::regexp(%w(http https))
        #, format: /https\://([\w-]+\.)+[\w-]+([w- ./?%\&\=]*)?/i
    validates :players_per_game,    presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to:10} 
    validates :file_location,       presence: true
end
=begin

/
    ([a-zA-Z][\-+.a-zA-Z\d]*):                           (?# 1: scheme)
        (?:
               ((?:[\-_.!~*'()a-zA-Z\d;?:@&=+$,]|%[a-fA-F\d]{2})(?:[\-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]|%[a-fA-F\d]{2})*)                    (?# 2: opaque)
                   |
                          (?:(?:
                                   \/\/(?:
                                                (?:(?:((?:[\-_.!~*'()a-zA-Z\d;:&=+$,]|%[a-fA-F\d]{2})*)@)?        (?# 3: userinfo)
                                                               (?:((?:(?:[a-zA-Z0-9\-.]|%\h\h)+|\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|\[(?:(?:[a-fA-F\d]{1,4}:)*(?:[a-fA-F\d]{1,4}|\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})|(?:(?:[a-fA-F\d]{1,4}:)*[a-fA-F\d]{1,4})?::(?:(?:[a-fA-F\d]{1,4}:)*(?:[a-fA-F\d]{1,4}|\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))?)\]))(?::(\d*))?))? (?# 4: host, 5: port)
                                                                          |
                                                                                       ((?:[\-_.!~*'()a-zA-Z\d$,;:@&=+]|%[a-fA-F\d]{2})+)                 (?# 6: registry)
                                                                                                  )
                                                                                                           |
                                                                                                                    (?!\/\/))                           (?# XXX: '\/\/' is the mark for hostport)
                                                                                                                             (\/(?:[\-_.!~*'()a-zA-Z\d:@&=+$,]|%[a-fA-F\d]{2})*(?:;(?:[\-_.!~*'()a-zA-Z\d:@&=+$,]|%[a-fA-F\d]{2})*)*(?:\/(?:[\-_.!~*'()a-zA-Z\d:@&=+$,]|%[a-fA-F\d]{2})*(?:;(?:[\-_.!~*'()a-zA-Z\d:@&=+$,]|%[a-fA-F\d]{2})*)*)*)?                    (?# 7: path)
                                                                                                                                    )(?:\?((?:[\-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]|%[a-fA-F\d]{2})*))?                 (?# 8: query)
                                                                                                                                        )
                                                                                                                                            (?:\#((?:[\-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]|%[a-fA-F\d]{2})*))?                  (?# 9: fragment)
                                                                                                                                              /x


=end
