class Plataforma < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_length_of :nome, :within => 5..50
  validates_presence_of :nome
  
  attr_protected :id
end
