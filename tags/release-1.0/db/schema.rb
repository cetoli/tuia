# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 18) do

  create_table "area_interesses", :force => true do |t|
    t.column "codigo", :string, :limit => 10, :default => "", :null => false
    t.column "nome",   :string, :limit => 50, :default => "", :null => false
  end

  add_index "area_interesses", ["codigo"], :name => "AitCodUnqIdx", :unique => true
  add_index "area_interesses", ["nome"], :name => "AitNomUnqIdx", :unique => true

  create_table "area_interesses_dado_academicos", :id => false, :force => true do |t|
    t.column "area_interess_id",  :integer
    t.column "dado_academico_id", :integer
  end

  create_table "areas", :force => true do |t|
    t.column "codigo",    :string,  :limit => 5,  :default => "",    :null => false
    t.column "nome",      :string,  :limit => 50, :default => "",    :null => false
    t.column "artigo",    :boolean,               :default => false, :null => false
    t.column "projeto",   :boolean,               :default => false, :null => false
    t.column "seminario", :boolean,               :default => false, :null => false
  end

  add_index "areas", ["codigo"], :name => "AreCodUnqIdx", :unique => true

  create_table "artigos", :force => true do |t|
    t.column "nome",     :string,  :default => "",    :null => false
    t.column "anexo",    :binary
    t.column "resumo",   :binary
    t.column "isresumo", :boolean, :default => false, :null => false
    t.column "usado",    :boolean, :default => false, :null => false
  end

  add_index "artigos", ["nome"], :name => "ArtNomUnqIdx", :unique => true

  create_table "cadastros", :force => true do |t|
    t.column "codigo",  :string,  :limit => 10, :default => "",    :null => false
    t.column "nome",    :string,  :limit => 50, :default => "",    :null => false
    t.column "leitura", :boolean,               :default => false, :null => false
  end

  add_index "cadastros", ["codigo"], :name => "CadCodUnqIdx", :unique => true

  create_table "dado_academicos", :force => true do |t|
    t.column "user_id",           :integer,                                :null => false
    t.column "turma_id",          :integer,                                :null => false
    t.column "escolaridade_id",   :integer,                                :null => false
    t.column "instituicao",       :string,  :limit => 100, :default => "", :null => false
    t.column "matricula",         :string,  :limit => 20,  :default => "", :null => false
    t.column "especialidade",     :string,                 :default => "", :null => false
    t.column "periodo",           :integer,                                :null => false
    t.column "datainicio",        :date,                                   :null => false
    t.column "datatermino",       :date,                                   :null => false
    t.column "titulo",            :string,                 :default => "", :null => false
    t.column "horario",           :string,                 :default => "", :null => false
    t.column "orientadorexterno", :string,                 :default => "", :null => false
    t.column "orientadorinterno", :string,                 :default => "", :null => false
  end

  add_index "dado_academicos", ["user_id"], :name => "FK_Dac_Usr"
  add_index "dado_academicos", ["turma_id"], :name => "FK_Dac_Tur"
  add_index "dado_academicos", ["escolaridade_id"], :name => "FK_Dac_Esc"

  create_table "dado_academicos_linha_pesquisas", :id => false, :force => true do |t|
    t.column "linha_pesquisa_id", :integer
    t.column "dado_academico_id", :integer
  end

  create_table "documentos", :force => true do |t|
    t.column "area_id",     :integer,                     :null => false
    t.column "user_id",     :integer,                     :null => false
    t.column "artigo_id",   :integer,                     :null => false
    t.column "titulo",      :string,   :default => "",    :null => false
    t.column "resenha",     :text,     :default => "",    :null => false
    t.column "nome_resumo", :string
    t.column "resumo",      :binary
    t.column "nome",        :string
    t.column "anexo",       :binary
    t.column "criado",      :datetime,                    :null => false
    t.column "alterado",    :datetime,                    :null => false
    t.column "aprovado",    :boolean,  :default => false, :null => false
  end

  add_index "documentos", ["titulo"], :name => "DocTitUnqIdx", :unique => true
  add_index "documentos", ["area_id"], :name => "FK_Doc_Are"
  add_index "documentos", ["user_id"], :name => "FK_Doc_Usr"
  add_index "documentos", ["artigo_id"], :name => "FK_Doc_Art"

  create_table "escolaridades", :force => true do |t|
    t.column "codigo", :string, :limit => 10, :default => "", :null => false
    t.column "nome",   :string, :limit => 50, :default => "", :null => false
  end

  add_index "escolaridades", ["codigo"], :name => "EscCodUnqIdx", :unique => true
  add_index "escolaridades", ["nome"], :name => "EscNomUnqIdx", :unique => true

  create_table "linha_pesquisas", :force => true do |t|
    t.column "codigo",    :string, :limit => 10,  :default => "", :null => false
    t.column "nome",      :string, :limit => 150, :default => "", :null => false
    t.column "nomeAnexo", :string
    t.column "anexo",     :binary
  end

  add_index "linha_pesquisas", ["codigo"], :name => "LpsCodUnqIdx", :unique => true
  add_index "linha_pesquisas", ["nome"], :name => "LpsNomUnqIdx", :unique => true

  create_table "livros", :force => true do |t|
    t.column "titulo",   :string, :default => "", :null => false
    t.column "nomeCapa", :string, :default => "", :null => false
    t.column "nomeCont", :string, :default => "", :null => false
    t.column "capa",     :binary
    t.column "conteudo", :binary
  end

  add_index "livros", ["titulo"], :name => "LivTitUnqIdx", :unique => true
  add_index "livros", ["nomeCapa"], :name => "LivNcaUnqIdx", :unique => true
  add_index "livros", ["nomeCont"], :name => "LivNcoUnqIdx", :unique => true

  create_table "manuals", :force => true do |t|
    t.column "titulo", :string, :default => "", :null => false
    t.column "nome",   :string, :default => "", :null => false
    t.column "anexo",  :binary
  end

  add_index "manuals", ["titulo"], :name => "ManTitUnqIdx", :unique => true
  add_index "manuals", ["nome"], :name => "ManNomUnqIdx", :unique => true

  create_table "modeloprovas", :force => true do |t|
    t.column "nome",     :string
    t.column "modelo",   :binary
    t.column "editavel", :integer,                 :null => false
    t.column "titulo",   :string,  :default => "", :null => false
  end

  add_index "modeloprovas", ["titulo"], :name => "MpvTitUnqIdx", :unique => true

  create_table "modelos", :force => true do |t|
    t.column "titulo", :string, :default => "", :null => false
    t.column "nome",   :string, :default => "", :null => false
    t.column "anexo",  :binary
  end

  add_index "modelos", ["titulo"], :name => "ModTitUnqIdx", :unique => true
  add_index "modelos", ["nome"], :name => "ModNomUnqIdx", :unique => true

  create_table "plataformas", :force => true do |t|
    t.column "codigo", :string, :limit => 10, :default => "", :null => false
    t.column "nome",   :string, :limit => 50, :default => "", :null => false
  end

  add_index "plataformas", ["codigo"], :name => "PlaCodUnqIdx", :unique => true
  add_index "plataformas", ["nome"], :name => "PlaNomUnqIdx", :unique => true

  create_table "plataformas_users", :id => false, :force => true do |t|
    t.column "plataforma_id", :integer
    t.column "user_id",       :integer
  end

  create_table "projetos", :force => true do |t|
    t.column "area_id",           :integer,                     :null => false
    t.column "user_id",           :integer,                     :null => false
    t.column "titulo",            :string,   :default => "",    :null => false
    t.column "resumo",            :text,     :default => "",    :null => false
    t.column "nome_situacao",     :string
    t.column "situacao",          :binary
    t.column "nome",              :string
    t.column "anexo",             :binary
    t.column "nome_apresentacao", :string
    t.column "apresentacao",      :binary
    t.column "criado",            :datetime,                    :null => false
    t.column "alterado",          :datetime,                    :null => false
    t.column "aprovado",          :boolean,  :default => false, :null => false
  end

  add_index "projetos", ["titulo"], :name => "PrjTitUnqIdx", :unique => true
  add_index "projetos", ["user_id"], :name => "FK_Prj_Usr"
  add_index "projetos", ["area_id"], :name => "FK_Prj_Are"

  create_table "roles", :force => true do |t|
    t.column "codigo", :string, :limit => 10, :default => "", :null => false
    t.column "nome",   :string, :limit => 50, :default => "", :null => false
  end

  add_index "roles", ["codigo"], :name => "RolCodUnqIdx", :unique => true
  add_index "roles", ["nome"], :name => "RolNomUnqIdx", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.column "role_id", :integer
    t.column "user_id", :integer
  end

  create_table "seminarios", :force => true do |t|
    t.column "area_id",      :integer,                     :null => false
    t.column "user_id",      :integer,                     :null => false
    t.column "titulo",       :string,   :default => "",    :null => false
    t.column "nomeTrab",     :string
    t.column "trabalho",     :binary
    t.column "nomeApres",    :string
    t.column "apresentacao", :binary
    t.column "criado",       :datetime,                    :null => false
    t.column "aprovado",     :boolean,  :default => false, :null => false
  end

  add_index "seminarios", ["titulo"], :name => "SemTitUnqIdx", :unique => true
  add_index "seminarios", ["area_id"], :name => "FK_Sem_Are"
  add_index "seminarios", ["user_id"], :name => "FK_Sem_Usr"

  create_table "turmas", :force => true do |t|
    t.column "codigo",      :string, :limit => 10, :default => "", :null => false
    t.column "nome",        :string, :limit => 50, :default => "", :null => false
    t.column "datainicio",  :date,                                 :null => false
    t.column "datatermino", :date,                                 :null => false
  end

  add_index "turmas", ["codigo"], :name => "TurCodUnqIdx", :unique => true

  create_table "users", :force => true do |t|
    t.column "cadastro_id",    :integer,                                   :null => false
    t.column "nome",           :string,  :limit => 50,  :default => "",    :null => false
    t.column "login",          :string,  :limit => 10,  :default => "",    :null => false
    t.column "pass",           :string,  :limit => 40,  :default => "",    :null => false
    t.column "salt",           :string,  :limit => 10,  :default => "",    :null => false
    t.column "email",          :string,  :limit => 45,  :default => "",    :null => false
    t.column "sexo",           :string,  :limit => 1,   :default => "",    :null => false
    t.column "nacionalidade",  :string,  :limit => 50,  :default => "",    :null => false
    t.column "naturalidade",   :string,  :limit => 100, :default => "",    :null => false
    t.column "bairro",         :string,  :limit => 50,  :default => "",    :null => false
    t.column "cep",            :string,  :limit => 10,  :default => "",    :null => false
    t.column "telefone",       :string,  :limit => 13,  :default => "",    :null => false
    t.column "celular",        :string,  :limit => 13,  :default => "",    :null => false
    t.column "endereco",       :string,                 :default => "",    :null => false
    t.column "datanascimento", :date,                                      :null => false
    t.column "admin",          :boolean,                :default => false, :null => false
    t.column "aprovado",       :boolean,                :default => false, :null => false
  end

  add_index "users", ["login"], :name => "UsrLogUnqIdx", :unique => true
  add_index "users", ["cadastro_id"], :name => "FK_Usr_Cad"

end
