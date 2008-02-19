class Turma < ActiveRecord::Base
#  has_many :users

  validates_presence_of :nome, :codigo
  validates_uniqueness_of :codigo
  validates_length_of :codigo, :within => 3..10
  validates_length_of :nome, :within => 5..50
  validates_date :datainicio, :before => :datatermino
  validates_date :datatermino, :after => :datainicio
  
  attr_protected :id
end
