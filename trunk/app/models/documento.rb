class Documento < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  
  validates_presence_of :titulo, :resenha, :criado, :alterado, :user_id, :area_id
  
  attr_protected :id, :criado, :alterado, :nome, :anexo, :aprovado
    
  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nome = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end
end
