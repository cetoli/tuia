class CreatePlataformas < ActiveRecord::Migration
  def self.up
    create_table :plataformas_users, :id => false do |t|
      t.column :plataforma_id, :integer
      t.column :user_id, :integer
    end

    create_table :plataformas do |t|
      t.column :codigo, :string, :limit => 10, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE plataformas ADD UNIQUE INDEX PlaCodUnqIdx USING BTREE(codigo)'
    execute 'ALTER TABLE plataformas ADD UNIQUE INDEX PlaNomUnqIdx USING BTREE(nome)'

    # Populate with Default Values
    Plataforma.create :codigo => 'ABRPA', :nome => 'ABRAPA'
    Plataforma.create :codigo => 'NRLOG', :nome => 'NEUROLOG'
    Plataforma.create :codigo => 'NINES', :nome => 'NEUROLAB INES'
    Plataforma.create :codigo => 'NLIBC', :nome => 'NEUROLAB IBC'
    Plataforma.create :codigo => 'INES', :nome => 'INES'
    Plataforma.create :codigo => 'IBC', :nome => 'IBC'
    Plataforma.create :codigo => 'CRIST', :nome => 'CRISTAAL'
    Plataforma.create :codigo => 'TUIA', :nome => 'TUIA'
    Plataforma.create :codigo => 'ESGRI', :nome => 'EsGRIMA'
    Plataforma.create :codigo => 'OURO', :nome => 'OURO'
    Plataforma.create :codigo => 'SLPAZ', :nome => 'SALA DA PAZ'
    Plataforma.create :codigo => 'JVPAZ', :nome => 'JUVENTUDE PELA PAZ'
    Plataforma.create :codigo => 'CAFAP', :nome => 'CAFÉ E APRENDIZAGEM'
  end

  def self.down
    drop_table :plataformas_users
    drop_table :plataformas
  end
end
