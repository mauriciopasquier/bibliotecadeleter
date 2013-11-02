class ProhibirNullsEnSlugDeTorneo < ActiveRecord::Migration
  def up
    Torneo.all.map(&:save)
  end

  def down
    Torneo.all.update_attribute(:slug, nil)
  end
end
