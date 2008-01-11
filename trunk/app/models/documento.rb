class Documento < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  
  validates_presence_of :titulo, :resenha, :criado, :alterado, :user_id, :area_id
  validates_uniqueness_of :titulo
  
  attr_protected :id, :criado, :alterado, :nome, :anexo, :aprovado, :nomeart, :artigo
    
  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nome = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end
    
  def artigos=(art_field)
    unless art_field.instance_of?(''.class)
      self.nomeart = art_field.original_filename
      self.artigo = art_field.read
    end
  end
end
