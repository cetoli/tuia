class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.column :codigo, :string, :limit => 5, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE areas ADD UNIQUE INDEX AreCodUnqIdx USING BTREE(codigo)'
  end

  def self.down
    drop_table :areas
  end
end
