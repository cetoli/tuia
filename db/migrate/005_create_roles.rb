class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.column "role_id" , :integer
      t.column "user_id" , :integer
    end

    create_table :roles do |t|
      t.column "nome" , :string, :null => false
    end

    execute 'ALTER TABLE roles ADD UNIQUE INDEX RolNomUnqIdx USING BTREE(nome)'
  end

  def self.down
    drop_table :roles_users
    drop_table :roles
  end
end
