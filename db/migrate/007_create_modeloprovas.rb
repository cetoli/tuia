class CreateModeloprovas < ActiveRecord::Migration
  def self.up
    create_table :modeloprovas do |t|
      t.column :nome, :string
      t.column :modelo, :binary
      t.column :editavel, :int, :null => false
      t.column :titulo, :string, :null => false
    end
    
    execute 'ALTER TABLE modeloprovas ADD UNIQUE INDEX MpvTitUnqIdx USING BTREE(titulo)'
  end

  def self.down
    drop_table :modeloprovas
  end
end
