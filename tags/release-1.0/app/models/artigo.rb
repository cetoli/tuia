class Artigo < ActiveRecord::Base
  has_one :documentos

  validates_presence_of :nome
  validates_uniqueness_of :nome

  attr_protected :id, :nome, :anexo, :resumo, :usado

  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nome = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end
end
