class LinhaPesquisa < ActiveRecord::Base
  has_and_belongs_to_many :dado_academicos

  validates_presence_of :nome, :codigo
  validates_uniqueness_of :nome, :codigo
  validates_length_of :codigo, :within => 3..10
  validates_length_of :nome, :within => 5..150
  
  attr_protected :id, :nomeAnexo, :anexo
    
  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nomeAnexo = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end
end
