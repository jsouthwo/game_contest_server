class ChangeDataTypeForDownloadableAndPlayableFromStringToBoolean < ActiveRecord::Migration
    def self.up
      change_table :players do |t|
        t.change :downloadable, :boolean
        t.change :playable, :boolean
      end
    end

    def self.down
      change_table :players do |t|
        t.change :downloadable, :string
        t.change :playable, :string
      end
    end
end
