class Modeloprova < ActiveRecord::Base
  validates_presence_of :editavel, :titulo
  validates_numericality_of :editavel, :only_integer => true, :greater_than => 0
  validates_inclusion_of :editavel, :in => 1..50, :message => "deve ser um inteiro entre 1 e 50."
  
  attr_protected :id, :nome, :modelo
    
  def modelos=(model_field)
    unless model_field.instance_of?(''.class)
      self.nome = model_field.original_filename
      self.modelo = model_field.read
    end
  end
end
