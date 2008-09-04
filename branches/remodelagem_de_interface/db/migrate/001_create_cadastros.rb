class CreateCadastros < ActiveRecord::Migration
  def self.up
    create_table :cadastros do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
      t.column :leitura, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE cadastros ADD UNIQUE INDEX CadCodUnqIdx USING BTREE(codigo)'

    # Populate with Default Values
    Cadastro.create :codigo => 'PROF', :nome => 'Profissional', :leitura => 0
  end

  def self.down
    drop_table :cadastros
  end
end
