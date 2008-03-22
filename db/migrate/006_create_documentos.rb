class CreateDocumentos < ActiveRecord::Migration
  def self.up
    create_table :documentos do |t|
      t.column :area_id, :int, :null => false
      t.column :user_id, :int, :null => false
      t.column :artigo_id, :int, :null => false
      t.column :titulo, :string, :null => false
      t.column :resenha, :text, :null => false
      t.column :nome_resumo, :string
      t.column :resumo, :binary, :limit => 5.megabytes
      t.column :nome, :string
      t.column :anexo, :binary, :limit => 5.megabytes
      t.column :criado, :datetime, :null => false
      t.column :alterado, :datetime, :null => false
      t.column :aprovado, :boolean, :default => 0, :null => false
    end

    execute 'ALTER TABLE documentos ADD UNIQUE INDEX DocTitUnqIdx USING BTREE(titulo)'
    execute 'ALTER TABLE documentos ADD CONSTRAINT FK_Doc_Are FOREIGN KEY FK_Doc_Are (area_id)
            REFERENCES areas (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE documentos ADD CONSTRAINT FK_Doc_Usr FOREIGN KEY FK_Doc_Usr (user_id)
            REFERENCES users (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
    execute 'ALTER TABLE documentos ADD CONSTRAINT FK_Doc_Art FOREIGN KEY FK_Doc_Art (artigo_id)
            REFERENCES artigos (id) ON DELETE RESTRICT ON UPDATE NO ACTION'
  end

  def self.down
    drop_table :documentos
  end
end
