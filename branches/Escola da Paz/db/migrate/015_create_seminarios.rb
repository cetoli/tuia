class CreateSeminarios < ActiveRecord::Migration
  def self.up
    create_table :seminarios do |t|
      t.column :area_id, :int, :null => false
      t.column :user_id, :int, :null => false
      t.column :titulo, :string, :null => false
      t.column :nomeTrab, :string
      t.column :trabalho, :binary, :limit => 5.megabytes
      t.column :nomeApres, :string
      t.column :apresentacao, :binary, :limit => 5.megabytes
      t.column :criado, :datetime, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE seminarios ADD UNIQUE INDEX SemTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE seminarios ADD CONSTRAINT FK_Sem_Are FOREIGN KEY FK_Sem_Are (area_id)
            REFERENCES areas (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE seminarios ADD CONSTRAINT FK_Sem_Usr FOREIGN KEY FK_Sem_Usr (user_id)
            REFERENCES users (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :seminarios
  end
end
