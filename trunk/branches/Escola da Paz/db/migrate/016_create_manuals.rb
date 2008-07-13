class CreateManuals < ActiveRecord::Migration
  def self.up
    create_table :manuals do |t|
      t.column :titulo, :string, :null => false
      t.column :nome, :string, :null => false
      t.column :anexo, :binary, :limit => 5.megabytes
    end

    execute 'ALTER TABLE manuals ADD UNIQUE INDEX ManTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE manuals ADD UNIQUE INDEX ManNomUnqIdx USING BTREE(nome)'
  end

  def self.down
    drop_table :manuals
  end
end
