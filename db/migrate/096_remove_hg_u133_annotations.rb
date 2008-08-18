class RemoveHgU133Annotations < ActiveRecord::Migration

  # this migration syncs lazar-gui with sensitiv
  def self.up
    drop_table :hg_u133_plus2_annotations
  end

end
