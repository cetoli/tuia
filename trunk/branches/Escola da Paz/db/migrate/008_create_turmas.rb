class CreateTurmas < ActiveRecord::Migration
  def self.up
    create_table :turmas do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
      t.column :datainicio, :date, :null => false
      t.column :datatermino, :date, :null => false
    end

    execute 'ALTER TABLE turmas ADD UNIQUE INDEX TurCodUnqIdx USING BTREE(codigo)'

    # Populate with Default Values
    Turma.create :codigo => 'DEF', :nome => 'Visitante', :datainicio => Date.new(2008, 01, 01), :datatermino => Date.new(2008, 12, 31)
  end

  def self.down
    drop_table :turmas
  end
end
