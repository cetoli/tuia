class Escolaridade < ActiveRecord::Base
#  has_many :users

  validates_presence_of :nome, :codigo
  validates_uniqueness_of :nome, :codigo
  validates_length_of :codigo, :within => 3..10
  validates_length_of :nome, :within => 5..50
  
  attr_protected :id
end
