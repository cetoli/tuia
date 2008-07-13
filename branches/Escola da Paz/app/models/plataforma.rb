class Plataforma < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_length_of :nome, :within => 3..50
  validates_length_of :codigo, :within => 3..10
  validates_presence_of :nome, :codigo
  validates_uniqueness_of :nome, :codigo
  
  attr_protected :id
end
