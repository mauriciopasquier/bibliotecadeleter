class AgregarLockableYConfirmableToUsuario < ActiveRecord::Migration
  def change
    ## Confirmable
    add_column :usuarios, :confirmation_token, :string
    add_column :usuarios, :confirmed_at, :datetime
    add_column :usuarios, :confirmation_sent_at, :datetime
    # Only if using reconfirmable
    add_column :usuarios, :unconfirmed_email, :string

    ## Lockable
    # Only if lock strategy is :failed_attempts
    add_column :usuarios, :failed_attempts, :integer, default: 0
    # Only if unlock strategy is :email or :both
    add_column :usuarios, :unlock_token, :string
    add_column :usuarios, :locked_at, :datetime

    add_index :usuarios, :confirmation_token, unique: true
    add_index :usuarios, :unlock_token, unique: true
  end
end
