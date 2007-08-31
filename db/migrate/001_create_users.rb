class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :nome, :string, :limit => 50, :null => false
      t.column :login, :string, :limit => 10, :null => false
      t.column :pass, :string, :limit => 40, :null => false
      t.column :salt, :string, :limit => 10, :null => false
      t.column :email, :string, :limit => 45, :null => false
      t.column :admin, :boolean, :default => 0, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE users ADD UNIQUE INDEX UsrLogUnqIdx USING BTREE(login)'
  end

  def self.down
    drop_table :users
  end
end
