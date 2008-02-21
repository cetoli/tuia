class CreateCadastros < ActiveRecord::Migration
  def self.up
    create_table :cadastros do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
      t.column :leitura, :boolean, :default => 1, :null => false
    end

    execute 'ALTER TABLE cadastros ADD UNIQUE INDEX CadCodUnqIdx USING BTREE(codigo)'
  end

  def self.down
    drop_table :cadastros
  end
end
