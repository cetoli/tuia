class CreateAreaInteresses < ActiveRecord::Migration
  def self.up
    create_table :area_interesses_dado_academicos, :id => false do |t|
      t.column :area_interess_id, :integer
      t.column :dado_academico_id, :integer
    end

    create_table :area_interesses do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE area_interesses ADD UNIQUE INDEX AitCodUnqIdx USING BTREE(codigo)'
    execute 'ALTER TABLE area_interesses ADD UNIQUE INDEX AitNomUnqIdx USING BTREE(nome)'

    # Populate with Default Values
    AreaInteress.create :codigo => 'NEUR', :nome => 'Neurologia'
    AreaInteress.create :codigo => 'PSIQ', :nome => 'Psiquiatria'
    AreaInteress.create :codigo => 'NRPS', :nome => 'Neuropsicologia'
    AreaInteress.create :codigo => 'PEDI', :nome => 'Pediatria'
    AreaInteress.create :codigo => 'OFTA', :nome => 'Oftalmologia'
    AreaInteress.create :codigo => 'OTLA', :nome => 'Otorrinolaringologia'
    AreaInteress.create :codigo => 'RADI', :nome => 'Radiologia'
    AreaInteress.create :codigo => 'BIOL', :nome => 'Biologia'
    AreaInteress.create :codigo => 'EBIO', :nome => 'Engenharia Biom�dica'
    AreaInteress.create :codigo => 'FONO', :nome => 'Fonoaudiologia'
    AreaInteress.create :codigo => 'SESO', :nome => 'Servi�o Social'
    AreaInteress.create :codigo => 'EDUC', :nome => 'Educa��o'
    AreaInteress.create :codigo => 'DESI', :nome => 'Design'
    AreaInteress.create :codigo => 'ARPL', :nome => 'Artes Pl�sticas'
    AreaInteress.create :codigo => 'DESE', :nome => 'Desenho'
    AreaInteress.create :codigo => 'MUSI', :nome => 'M�sica'
    AreaInteress.create :codigo => 'PSIC', :nome => 'Psicologia'
    AreaInteress.create :codigo => 'LING', :nome => 'Ling��stica'
    AreaInteress.create :codigo => 'LETR', :nome => 'Letras'
    AreaInteress.create :codigo => 'ANTR', :nome => 'Antropologia'
    AreaInteress.create :codigo => 'LOGI', :nome => 'L�gica'
    AreaInteress.create :codigo => 'MATE', :nome => 'Matem�tica'
    AreaInteress.create :codigo => 'CICO', :nome => 'Ci�ncias da Computa��o'
    AreaInteress.create :codigo => 'PSPE', :nome => 'Psicopedagogia'
    AreaInteress.create :codigo => 'DIHU', :nome => 'Direitos Humanos'
    AreaInteress.create :codigo => 'OUTR', :nome => 'Outros'
  end

  def self.down
    drop_table :area_interesses_dado_academicos
    drop_table :area_interesses
  end
end
