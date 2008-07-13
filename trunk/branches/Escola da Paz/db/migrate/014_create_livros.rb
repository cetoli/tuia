class CreateLivros < ActiveRecord::Migration
  def self.up
    create_table :livros do |t|
      t.column :titulo, :string, :null => false
      t.column :nomeCapa, :string, :null => false
      t.column :nomeCont, :string, :null => false
      t.column :capa, :binary, :limit => 5.megabytes
      t.column :conteudo, :binary, :limit => 5.megabytes
    end

    execute 'ALTER TABLE livros ADD UNIQUE INDEX LivTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE livros ADD UNIQUE INDEX LivNcaUnqIdx USING BTREE(nomeCapa)'
    execute 'ALTER TABLE livros ADD UNIQUE INDEX LivNcoUnqIdx USING BTREE(nomeCont)'
  end

  def self.down
    drop_table :livros
  end
end
