# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 1) do

  create_table "areas", :force => true do |t|
    t.column "codigo", :string, :limit => 5,  :default => "", :null => false
    t.column "nome",   :string, :limit => 50, :default => "", :null => false
  end

  add_index "areas", ["codigo"], :name => "AreCodUnqIdx", :unique => true

  create_table "documentos", :force => true do |t|
    t.column "area_id",  :integer,                     :null => false
    t.column "user_id",  :integer,                     :null => false
    t.column "titulo",   :string,   :default => "",    :null => false
    t.column "resenha",  :text,     :default => "",    :null => false
    t.column "nome",     :string
    t.column "anexo",    :binary
    t.column "criado",   :datetime,                    :null => false
    t.column "alterado", :datetime,                    :null => false
    t.column "aprovado", :boolean,  :default => false, :null => false
  end

  add_index "documentos", ["titulo"], :name => "DocTitUnqIdx", :unique => true
  add_index "documentos", ["area_id"], :name => "FK_Doc_Are"
  add_index "documentos", ["user_id"], :name => "FK_Doc_Usr"

  create_table "users", :force => true do |t|
    t.column "nome",     :string,  :limit => 50, :default => "",    :null => false
    t.column "login",    :string,  :limit => 10, :default => "",    :null => false
    t.column "pass",     :string,  :limit => 40, :default => "",    :null => false
    t.column "salt",     :string,  :limit => 10, :default => "",    :null => false
    t.column "email",    :string,  :limit => 45, :default => "",    :null => false
    t.column "admin",    :boolean,               :default => false, :null => false
    t.column "aprovado", :boolean,               :default => false, :null => false
  end

  add_index "users", ["login"], :name => "UsrLogUnqIdx", :unique => true

end