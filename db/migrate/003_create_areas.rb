class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.column :codigo, :string, :limit => 5, :null => false
      t.column :nome, :string, :limit => 50, :null => false
    end

    execute 'ALTER TABLE areas ADD UNIQUE INDEX AreCodUnqIdx USING BTREE(codigo)'

    # Populate with Default Values
    Area.create :codigo => 'FPSCI', :nome => 'A FUNDAÇÃO DA PSICOLOGIA CIENTÍFICA'
    Area.create :codigo => 'PSIFN', :nome => 'A PSICANÁLISE E A FONOAUDIOLOGIA'
    Area.create :codigo => 'ESGES', :nome => 'A ESCOLA DA GESTALT'
    Area.create :codigo => 'BEHAV', :nome => 'BEHAVIORISMO'
    Area.create :codigo => 'JPIAG', :nome => 'J. PIAGET'
    Area.create :codigo => 'CHOMS', :nome => 'CHOMSKY'
    Area.create :codigo => 'LSVIG', :nome => 'L.S. VIGOTSKY'
    Area.create :codigo => 'PPSLI', :nome => 'PROBLEMAS PSICOLÓGICOS E LINGUAGEM'
    Area.create :codigo => 'JBRUN', :nome => 'J. BRUNER'
    Area.create :codigo => 'ABAND', :nome => 'A. BANDURA'
    Area.create :codigo => 'JFLAV', :nome => 'J. FLAVELL'
    Area.create :codigo => 'LURIA', :nome => 'LURIA'
    Area.create :codigo => 'CICOG', :nome => 'AS CIÊNCIAS DA COGNIÇÃO'
  end

  def self.down
    drop_table :areas
  end
end
