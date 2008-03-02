class Livro < ActiveRecord::Base
  validates_presence_of :nomeCapa, :nomeCont, :titulo

  attr_accessor :capaCntType, :contCntType
  attr_protected :id, :nomeCapa, :nomeCont, :capa, :conteudo

  def capas=(capa_field)
    unless capa_field.instance_of?(''.class)
      self.capaCntType = capa_field.content_type
      self.nomeCapa = capa_field.original_filename
      self.capa = capa_field.read
    end
  end

  def conteudos=(cont_field)
    unless cont_field.instance_of?(''.class)
      self.contCntType = cont_field.content_type
      self.nomeCont = cont_field.original_filename
      self.conteudo = cont_field.read
    end
  end

  protected

  def validate
    # Valida content-type da capa (JPEG)
    if self.nomeCapa.length > 0 and self.capaCntType !~ /^image\/jpeg/
      errors.add(:capa, "A capa deve ser um arquivo do tipo JPEG! Foi enviado #{self.capaCntType} (#{self.nomeCapa}).")
    end
    # Valida content-type do conteúdo (DOC)
    if self.nomeCont.length > 0 and self.contCntType !~ /^application\/msword/
      errors.add(:conteudo, "O conteúdo deve ser um arquivo do tipo DOC! Foi enviado #{self.contCntType} (#{self.nomeCont}).")
    end
  end
end
