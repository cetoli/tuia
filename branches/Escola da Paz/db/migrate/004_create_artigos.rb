class CreateArtigos < ActiveRecord::Migration
  def self.up
    create_table :artigos do |t|
      t.column :nome, :string, :null => false
      t.column :anexo, :binary, :limit => 5.megabytes
      t.column :resumo, :binary, :limit => 5.megabytes
      t.column :isresumo, :boolean, :default => 0, :null => false
      t.column :usado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE artigos ADD UNIQUE INDEX ArtNomUnqIdx USING BTREE(nome)'
  end

  def self.down
    drop_table :artigos
  end
end
