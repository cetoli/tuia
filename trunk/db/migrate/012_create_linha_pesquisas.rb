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
    LinhaPesquisa.create :codigo => 'L1LAB', :nome => 'Linha 1 - LABIRINTO: Neurociências da Cognição e Informatização de Dados'
    LinhaPesquisa.create :codigo => 'L2PDG', :nome => 'Linha 2 - PULO DO GATO: Neurociências dos Jogos Computadorizados'
    LinhaPesquisa.create :codigo => 'L3OLV', :nome => 'Linha 3 - OLHO VIVO: Avaliação Neuropsicológica Computadorizada'
    LinhaPesquisa.create :codigo => 'L4CDC', :nome => 'Linha 4 - COLHER DE CHÁ: Programas de Automatização em Neurociências'
    LinhaPesquisa.create :codigo => 'L5SMT', :nome => 'Linha 5 - SALAS METACOGNITIVAS: Neuropedagogia, Metacognição e Jogos Informatizados'
    LinhaPesquisa.create :codigo => 'L6CRP', :nome => 'Linha 6 - CAIU NA REDE É PEIXE: Aprendizagem Colaborativa e Neurociências'
    LinhaPesquisa.create :codigo => 'L7BDG', :nome => 'Linha 7 - BOLA DE GUDE: Jogos Computadorizados e Design Social'
    LinhaPesquisa.create :codigo => 'L8PNT', :nome => 'Linha 8 - PÉ NA TÁBUA: Programas de Aceleração Cognitiva'
  end

  def self.down
    drop_table :linha_pesquisas_dado_academicos
    drop_table :linha_pesquisas
  end
end
