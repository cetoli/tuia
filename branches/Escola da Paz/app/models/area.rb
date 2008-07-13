class Area < ActiveRecord::Base
  has_many :documentos

  validates_length_of :codigo, :maximum => 5
  validates_length_of :nome, :maximum => 50
  validates_presence_of :codigo, :nome
  validates_uniqueness_of :codigo
  
  attr_protected :id
end
