class FixUsuarioCodigoIndex < ActiveRecord::Migration
  def up
    if index_exists?(:usuarios, :codigo)
      remove_index(:usuarios, :codigo)
    end
  end

  def down
    # Nada que hacer
  end
end
