class CreatePlataformas < ActiveRecord::Migration
  def self.up
    create_table :plataformas_users, :id => false do |t|
      t.column "plataforma_id" , :integer
      t.column "user_id" , :integer
    end

    create_table :plataformas do |t|
      t.column "nome" , :string, :null => false
    end

    execute 'ALTER TABLE plataformas ADD UNIQUE INDEX PlaNomUnqIdx USING BTREE(nome)'
  end

  def self.down
    drop_table :plataformas_users
    drop_table :plataformas
  end
end
