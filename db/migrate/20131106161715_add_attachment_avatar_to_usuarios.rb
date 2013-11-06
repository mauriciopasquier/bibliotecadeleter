class AddAttachmentAvatarToUsuarios < ActiveRecord::Migration
  def self.up
    change_table :usuarios do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :usuarios, :avatar
  end
end
