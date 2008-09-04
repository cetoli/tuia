class CreateModelos < ActiveRecord::Migration
  def self.up
    create_table :modelos do |t|
      t.column :titulo, :string, :null => false
      t.column :nome, :string, :null => false
      t.column :anexo, :binary, :limit => 5.megabytes
    end

    execute 'ALTER TABLE modelos ADD UNIQUE INDEX ModTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE modelos ADD UNIQUE INDEX ModNomUnqIdx USING BTREE(nome)'
  end

  def self.down
    drop_table :modelos
  end
end
