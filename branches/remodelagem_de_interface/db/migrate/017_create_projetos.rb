class CreateProjetos < ActiveRecord::Migration
  def self.up
    create_table :projetos do |t|
      t.column :area_id, :int, :null => false
      t.column :user_id, :int, :null => false
      t.column :titulo, :string, :null => false
      t.column :resumo, :text, :null => false
      t.column :nome_situacao, :string
      t.column :situacao, :binary, :limit => 5.megabytes
      t.column :nome, :string
      t.column :anexo, :binary, :limit => 5.megabytes
      t.column :nome_apresentacao, :string
      t.column :apresentacao, :binary, :limit => 5.megabytes
      t.column :criado, :datetime, :null => false
      t.column :alterado, :datetime, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE projetos ADD UNIQUE INDEX PrjTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE projetos ADD CONSTRAINT FK_Prj_Usr FOREIGN KEY FK_Prj_Usr (user_id)
            REFERENCES users (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE projetos ADD CONSTRAINT FK_Prj_Are FOREIGN KEY FK_Prj_Are (area_id)
            REFERENCES areas (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :projetos
  end
end
