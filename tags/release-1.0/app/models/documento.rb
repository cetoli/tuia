class Documento < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  belongs_to :artigo

  validates_presence_of :titulo, :resenha, :criado, :alterado, :user_id, :area_id, :artigo_id
  validates_uniqueness_of :titulo

  attr_protected :id, :criado, :alterado, :nome_resumo, :resumo, :nome, :anexo, :aprovado

  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nome = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end

  def resumos=(resumo_field)
    unless resumo_field.instance_of?(''.class)
      self.nome_resumo = resumo_field.original_filename
      self.resumo = resumo_field.read
    end
  end
end
