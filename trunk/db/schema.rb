# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 18) do

  create_table "area_interesses", :force => true do |t|
    t.string "codigo", :limit => 10, :null => false
    t.string "nome",   :limit => 50, :null => false
  end

  add_index "area_interesses", ["codigo"], :name => "AitCodUnqIdx", :unique => true
  add_index "area_interesses", ["nome"], :name => "AitNomUnqIdx", :unique => true

  create_table "area_interesses_dado_academicos", :id => false, :force => true do |t|
    t.integer "area_interess_id"
    t.integer "dado_academico_id"
  end

  create_table "areas", :force => true do |t|
    t.string  "codigo",    :limit => 5,                     :null => false
    t.string  "nome",      :limit => 50,                    :null => false
    t.boolean "artigo",                  :default => false, :null => false
    t.boolean "projeto",                 :default => false, :null => false
    t.boolean "seminario",               :default => false, :null => false
  end

  add_index "areas", ["codigo"], :name => "AreCodUnqIdx", :unique => true

  create_table "artigos", :force => true do |t|
    t.string  "nome",                                            :null => false
    t.binary  "anexo",    :limit => 16777215
    t.binary  "resumo",   :limit => 16777215
    t.boolean "isresumo",                     :default => false, :null => false
    t.boolean "usado",                        :default => false, :null => false
  end

  add_index "artigos", ["nome"], :name => "ArtNomUnqIdx", :unique => true

  create_table "cadastros", :force => true do |t|
    t.string  "codigo",  :limit => 10,                    :null => false
    t.string  "nome",    :limit => 50,                    :null => false
    t.boolean "leitura",               :default => false, :null => false
  end

  add_index "cadastros", ["codigo"], :name => "CadCodUnqIdx", :unique => true

  create_table "dado_academicos", :force => true do |t|
    t.integer "user_id",                          :null => false
    t.integer "turma_id",                         :null => false
    t.integer "escolaridade_id",                  :null => false
    t.string  "instituicao",       :limit => 100, :null => false
    t.string  "matricula",         :limit => 20,  :null => false
    t.string  "especialidade",                    :null => false
    t.integer "periodo",                          :null => false
    t.date    "datainicio",                       :null => false
    t.date    "datatermino",                      :null => false
    t.string  "titulo",                           :null => false
    t.string  "horario",                          :null => false
    t.string  "orientadorexterno",                :null => false
    t.string  "orientadorinterno",                :null => false
  end

  add_index "dado_academicos", ["escolaridade_id"], :name => "FK_Dac_Esc"
  add_index "dado_academicos", ["turma_id"], :name => "FK_Dac_Tur"
  add_index "dado_academicos", ["user_id"], :name => "FK_Dac_Usr"

  create_table "dado_academicos_linha_pesquisas", :id => false, :force => true do |t|
    t.integer "linha_pesquisa_id"
    t.integer "dado_academico_id"
  end

  create_table "documentos", :force => true do |t|
    t.integer  "area_id",                                            :null => false
    t.integer  "user_id",                                            :null => false
    t.integer  "artigo_id",                                          :null => false
    t.string   "titulo",                                             :null => false
    t.text     "resenha",                                            :null => false
    t.string   "nome_resumo"
    t.binary   "resumo",      :limit => 16777215
    t.string   "nome"
    t.binary   "anexo",       :limit => 16777215
    t.datetime "criado",                                             :null => false
    t.datetime "alterado",                                           :null => false
    t.boolean  "aprovado",                        :default => false, :null => false
  end

  add_index "documentos", ["area_id"], :name => "FK_Doc_Are"
  add_index "documentos", ["artigo_id"], :name => "FK_Doc_Art"
  add_index "documentos", ["titulo"], :name => "DocTitUnqIdx", :unique => true
  add_index "documentos", ["user_id"], :name => "FK_Doc_Usr"

  create_table "escolaridades", :force => true do |t|
    t.string "codigo", :limit => 10, :null => false
    t.string "nome",   :limit => 50, :null => false
  end

  add_index "escolaridades", ["codigo"], :name => "EscCodUnqIdx", :unique => true
  add_index "escolaridades", ["nome"], :name => "EscNomUnqIdx", :unique => true

  create_table "linha_pesquisas", :force => true do |t|
    t.string "codigo",    :limit => 10,  :null => false
    t.string "nome",      :limit => 150, :null => false
    t.string "nomeAnexo"
    t.binary "anexo"
  end

  add_index "linha_pesquisas", ["codigo"], :name => "LpsCodUnqIdx", :unique => true
  add_index "linha_pesquisas", ["nome"], :name => "LpsNomUnqIdx", :unique => true

  create_table "livros", :force => true do |t|
    t.string "titulo",                       :null => false
    t.string "nomeCapa",                     :null => false
    t.string "nomeCont",                     :null => false
    t.binary "capa",     :limit => 16777215
    t.binary "conteudo", :limit => 16777215
  end

  add_index "livros", ["nomeCapa"], :name => "LivNcaUnqIdx", :unique => true
  add_index "livros", ["nomeCont"], :name => "LivNcoUnqIdx", :unique => true
  add_index "livros", ["titulo"], :name => "LivTitUnqIdx", :unique => true

  create_table "manuals", :force => true do |t|
    t.string "titulo",                     :null => false
    t.string "nome",                       :null => false
    t.binary "anexo",  :limit => 16777215
  end

  add_index "manuals", ["nome"], :name => "ManNomUnqIdx", :unique => true
  add_index "manuals", ["titulo"], :name => "ManTitUnqIdx", :unique => true

  create_table "modeloprovas", :force => true do |t|
    t.string  "nome"
    t.binary  "modelo",   :limit => 16777215
    t.integer "editavel",                     :null => false
    t.string  "titulo",                       :null => false
  end

  add_index "modeloprovas", ["titulo"], :name => "MpvTitUnqIdx", :unique => true

  create_table "modelos", :force => true do |t|
    t.string "titulo",                     :null => false
    t.string "nome",                       :null => false
    t.binary "anexo",  :limit => 16777215
  end

  add_index "modelos", ["nome"], :name => "ModNomUnqIdx", :unique => true
  add_index "modelos", ["titulo"], :name => "ModTitUnqIdx", :unique => true

  create_table "plataformas", :force => true do |t|
    t.string "codigo", :limit => 10, :null => false
    t.string "nome",   :limit => 50, :null => false
  end

  add_index "plataformas", ["codigo"], :name => "PlaCodUnqIdx", :unique => true
  add_index "plataformas", ["nome"], :name => "PlaNomUnqIdx", :unique => true

  create_table "plataformas_users", :id => false, :force => true do |t|
    t.integer "plataforma_id"
    t.integer "user_id"
  end

  create_table "projetos", :force => true do |t|
    t.integer  "area_id",                                                  :null => false
    t.integer  "user_id",                                                  :null => false
    t.string   "titulo",                                                   :null => false
    t.text     "resumo",                                                   :null => false
    t.string   "nome_situacao"
    t.binary   "situacao",          :limit => 16777215
    t.string   "nome"
    t.binary   "anexo",             :limit => 16777215
    t.string   "nome_apresentacao"
    t.binary   "apresentacao",      :limit => 16777215
    t.datetime "criado",                                                   :null => false
    t.datetime "alterado",                                                 :null => false
    t.boolean  "aprovado",                              :default => false, :null => false
  end

  add_index "projetos", ["area_id"], :name => "FK_Prj_Are"
  add_index "projetos", ["titulo"], :name => "PrjTitUnqIdx", :unique => true
  add_index "projetos", ["user_id"], :name => "FK_Prj_Usr"

  create_table "roles", :force => true do |t|
    t.string "codigo", :limit => 10, :null => false
    t.string "nome",   :limit => 50, :null => false
  end

  add_index "roles", ["codigo"], :name => "RolCodUnqIdx", :unique => true
  add_index "roles", ["nome"], :name => "RolNomUnqIdx", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "seminarios", :force => true do |t|
    t.integer  "area_id",                                             :null => false
    t.integer  "user_id",                                             :null => false
    t.string   "titulo",                                              :null => false
    t.string   "nomeTrab"
    t.binary   "trabalho",     :limit => 16777215
    t.string   "nomeApres"
    t.binary   "apresentacao", :limit => 16777215
    t.datetime "criado",                                              :null => false
    t.boolean  "aprovado",                         :default => false, :null => false
  end

  add_index "seminarios", ["area_id"], :name => "FK_Sem_Are"
  add_index "seminarios", ["titulo"], :name => "SemTitUnqIdx", :unique => true
  add_index "seminarios", ["user_id"], :name => "FK_Sem_Usr"

  create_table "turmas", :force => true do |t|
    t.string "codigo",      :limit => 10, :null => false
    t.string "nome",        :limit => 50, :null => false
    t.date   "datainicio",                :null => false
    t.date   "datatermino",               :null => false
  end

  add_index "turmas", ["codigo"], :name => "TurCodUnqIdx", :unique => true

  create_table "users", :force => true do |t|
    t.integer "cadastro_id",                                      :null => false
    t.string  "nome",           :limit => 50,                     :null => false
    t.string  "login",          :limit => 10,                     :null => false
    t.string  "pass",           :limit => 40,                     :null => false
    t.string  "salt",           :limit => 10,                     :null => false
    t.string  "email",          :limit => 45,                     :null => false
    t.string  "sexo",           :limit => 1,                      :null => false
    t.string  "nacionalidade",  :limit => 50,                     :null => false
    t.string  "naturalidade",   :limit => 100,                    :null => false
    t.string  "bairro",         :limit => 50,                     :null => false
    t.string  "cep",            :limit => 10,                     :null => false
    t.string  "telefone",       :limit => 13,                     :null => false
    t.string  "celular",        :limit => 13,                     :null => false
    t.string  "endereco",                                         :null => false
    t.date    "datanascimento",                                   :null => false
    t.boolean "admin",                         :default => false, :null => false
    t.boolean "aprovado",                      :default => false, :null => false
  end

  add_index "users", ["cadastro_id"], :name => "FK_Usr_Cad"
  add_index "users", ["login"], :name => "UsrLogUnqIdx", :unique => true

end
