class AreaInteress < ActiveRecord::Base
  has_and_belongs_to_many :dado_academicos

  validates_presence_of :nome, :codigo
  validates_uniqueness_of :nome, :codigo
  validates_length_of :codigo, :within => 3..10
  validates_length_of :nome, :within => 1..50
  
  attr_protected :id
end
