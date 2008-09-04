class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :cadastro_id, :int, :null => false
      t.column :nome, :string, :limit => 50, :null => false
      t.column :login, :string, :limit => 10, :null => false
      t.column :pass, :string, :limit => 40, :null => false
      t.column :salt, :string, :limit => 10, :null => false
      t.column :email, :string, :limit => 45, :null => false
      t.column :sexo, :string, :limit => 1, :null => false
      t.column :nacionalidade, :string, :limit => 50, :null => false
      t.column :naturalidade, :string, :limit => 100, :null => false
      t.column :bairro, :string, :limit => 50, :null => false
      t.column :cep, :string, :limit => 10, :null => false
      t.column :telefone, :string, :limit => 13, :null => false
      t.column :celular, :string, :limit => 13, :null => false
      t.column :endereco, :string, :null => false
      t.column :datanascimento, :date, :null => false
      t.column :admin, :boolean, :default => 0, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE users ADD UNIQUE INDEX UsrLogUnqIdx USING BTREE(login)'
    execute 'ALTER TABLE users ADD CONSTRAINT FK_Usr_Cad FOREIGN KEY FK_Usr_Cad (cadastro_id)
            REFERENCES cadastros (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :users
  end
end
