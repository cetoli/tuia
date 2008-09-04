class CreateDadoAcademicos < ActiveRecord::Migration
  def self.up
    create_table :dado_academicos do |t|
      t.column :user_id, :int, :null => false
      t.column :turma_id, :int, :null => false
      t.column :escolaridade_id, :int, :null => false
      t.column :instituicao, :string, :limit => 100, :null => false
      t.column :matricula, :string, :limit => 20, :null => false
      t.column :especialidade, :string, :null => false
      t.column :periodo, :int, :null => false
      t.column :datainicio, :date, :null => false
      t.column :datatermino, :date, :null => false
      t.column :titulo, :string, :null => false
      t.column :horario, :string, :null => false
      t.column :orientadorexterno, :string, :null => false
      t.column :orientadorinterno, :string, :null => false
    end

    execute 'ALTER TABLE dado_academicos ADD CONSTRAINT FK_Dac_Usr FOREIGN KEY FK_Dac_Usr (user_id)
            REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION'
    execute 'ALTER TABLE dado_academicos ADD CONSTRAINT FK_Dac_Tur FOREIGN KEY FK_Dac_Tur (turma_id)
            REFERENCES turmas (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE dado_academicos ADD CONSTRAINT FK_Dac_Esc FOREIGN KEY FK_Dac_Esc (escolaridade_id)
            REFERENCES escolaridades (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :dado_academicos
  end
end
