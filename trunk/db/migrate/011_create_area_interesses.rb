class CreateAreaInteresses < ActiveRecord::Migration
  def self.up
    create_table :area_interesses_dado_academicos, :id => false do |t|
      t.column :area_interesse_id, :integer
      t.column :dado_academico_id, :integer
    end

    create_table :area_interesses do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE area_interesses ADD UNIQUE INDEX AitCodUnqIdx USING BTREE(codigo)'
    execute 'ALTER TABLE area_interesses ADD UNIQUE INDEX AitNomUnqIdx USING BTREE(nome)'

    # Populate with Default Values
    AreaInteresse.create :codigo => 'NEUR', :nome => 'Neurologia'
    AreaInteresse.create :codigo => 'PSIQ', :nome => 'Psiquiatria'
    AreaInteresse.create :codigo => 'NRPS', :nome => 'Neuropsicologia'
    AreaInteresse.create :codigo => 'PEDI', :nome => 'Pediatria'
    AreaInteresse.create :codigo => 'OFTA', :nome => 'Oftalmologia'
    AreaInteresse.create :codigo => 'OTLA', :nome => 'Otorrinolaringologia'
    AreaInteresse.create :codigo => 'RADI', :nome => 'Radiologia'
    AreaInteresse.create :codigo => 'BIOL', :nome => 'Biologia'
    AreaInteresse.create :codigo => 'EBIO', :nome => 'Engenharia Biom�dica'
    AreaInteresse.create :codigo => 'FONO', :nome => 'Fonoaudiologia'
    AreaInteresse.create :codigo => 'SESO', :nome => 'Servi�o Social'
    AreaInteresse.create :codigo => 'EDUC', :nome => 'Educa��o'
    AreaInteresse.create :codigo => 'DESI', :nome => 'Design'
    AreaInteresse.create :codigo => 'ARPL', :nome => 'Artes Pl�sticas'
    AreaInteresse.create :codigo => 'DESE', :nome => 'Desenho'
    AreaInteresse.create :codigo => 'MUSI', :nome => 'M�sica'
    AreaInteresse.create :codigo => 'PSIC', :nome => 'Psicologia'
    AreaInteresse.create :codigo => 'LING', :nome => 'Ling��stica'
    AreaInteresse.create :codigo => 'LETR', :nome => 'Letras'
    AreaInteresse.create :codigo => 'ANTR', :nome => 'Antropologia'
    AreaInteresse.create :codigo => 'LOGI', :nome => 'L�gica'
    AreaInteresse.create :codigo => 'MATE', :nome => 'Matem�tica'
    AreaInteresse.create :codigo => 'CICO', :nome => 'Ci�ncias da Computa��o'
    AreaInteresse.create :codigo => 'PSPE', :nome => 'Psicopedagogia'
    AreaInteresse.create :codigo => 'DIHU', :nome => 'Direitos Humanos'
    AreaInteresse.create :codigo => 'OUTR', :nome => 'Outros'
  end

  def self.down
    drop_table :area_interesses_dado_academicos
    drop_table :area_interesses
  end
end
