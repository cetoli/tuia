class Projeto < ActiveRecord::Base
  belongs_to :user
  belongs_to :area

  validates_presence_of :titulo, :resumo, :criado, :alterado, :user_id, :area_id
  validates_uniqueness_of :titulo

  attr_protected :id, :criado, :alterado, :nome_situacao, :situacao, :nome, :anexo, :nome_apresentacao, :apresentacao, :aprovado

  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nome = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end

  def situacaos=(situ_field)
    unless situ_field.instance_of?(''.class)
      self.nome_situacao = situ_field.original_filename
      self.situacao = situ_field.read
    end
  end

  def apresentacaos=(apres_field)
    unless apres_field.instance_of?(''.class)
      self.nome_apresentacao = apres_field.original_filename
      self.apresentacao = apres_field.read
    end
  end
end
