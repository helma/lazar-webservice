class LazarToVersion79 < ActiveRecord::Migration
  def self.up
    Engines.plugins["lazar"].migrate(79)
  end

  def self.down
    Engines.plugins["opentox"].migrate(76)
  end
end
