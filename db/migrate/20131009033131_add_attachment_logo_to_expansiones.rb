class AddAttachmentLogoToExpansiones < ActiveRecord::Migration
  def self.up
    change_table :expansiones do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :expansiones, :logo
  end
end
