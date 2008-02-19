class CreateTurmas < ActiveRecord::Migration
  def self.up
    create_table :turmas do |t|
      t.column :codigo, :string, :null => false
      t.column :nome, :string, :null => false
      t.column :datainicio, :date, :null => false
      t.column :datatermino, :date, :null => false
    end

    execute 'ALTER TABLE turmas ADD UNIQUE INDEX TurCodUnqIdx USING BTREE(codigo)'
  end

  def self.down
    drop_table :turmas
  end
end
