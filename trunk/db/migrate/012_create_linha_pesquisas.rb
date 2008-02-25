class CreateLinhaPesquisas < ActiveRecord::Migration
  def self.up
    create_table :linha_pesquisas_dado_academicos, :id => false do |t|
      t.column :linha_pesquisa_id, :integer
      t.column :dado_academico_id, :integer
    end

    create_table :linha_pesquisas do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 150, :null => false
      t.column :nomeAnexo, :string
      t.column :anexo, :binary
    end

    execute 'ALTER TABLE linha_pesquisas ADD UNIQUE INDEX LpsCodUnqIdx USING BTREE(codigo)'
    execute 'ALTER TABLE linha_pesquisas ADD UNIQUE INDEX LpsNomUnqIdx USING BTREE(nome)'

    # Populate with Default Values
    LinhaPesquisa.create :codigo => 'L1LAB', :nome => 'Linha 1 - LABIRINTO: Neuroci�ncias da Cogni��o e Informatiza��o de Dados'
    LinhaPesquisa.create :codigo => 'L2PDG', :nome => 'Linha 2 - PULO DO GATO: Neuroci�ncias dos Jogos Computadorizados'
    LinhaPesquisa.create :codigo => 'L3OLV', :nome => 'Linha 3 - OLHO VIVO: Avalia��o Neuropsicol�gica Computadorizada'
    LinhaPesquisa.create :codigo => 'L4CDC', :nome => 'Linha 4 - COLHER DE CH�: Programas de Automatiza��o em Neuroci�ncias'
    LinhaPesquisa.create :codigo => 'L5SMT', :nome => 'Linha 5 - SALAS METACOGNITIVAS: Neuropedagogia, Metacogni��o e Jogos Informatizados'
    LinhaPesquisa.create :codigo => 'L6CRP', :nome => 'Linha 6 - CAIU NA REDE � PEIXE: Aprendizagem Colaborativa e Neuroci�ncias'
    LinhaPesquisa.create :codigo => 'L7BDG', :nome => 'Linha 7 - BOLA DE GUDE: Jogos Computadorizados e Design Social'
    LinhaPesquisa.create :codigo => 'L8PNT', :nome => 'Linha 8 - P� NA T�BUA: Programas de Acelera��o Cognitiva'
  end

  def self.down
    drop_table :linha_pesquisas_dado_academicos
    drop_table :linha_pesquisas
  end
end
