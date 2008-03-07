class Seminario < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  
  validates_presence_of :titulo, :criado, :nomeTrab, :nomeApres, :user_id, :area_id
  validates_uniqueness_of :titulo
  
  attr_protected :id, :criado, :nomeTrab, :trabalho, :nomeApres, :apresentacao, :aprovado
  attr_accessor :trabCntType, :apresCntType

  def trabalhos=(trab_field)
    self.nomeTrab = ""
    unless trab_field.instance_of?(''.class)
      self.trabCntType = trab_field.content_type
      self.nomeTrab = trab_field.original_filename
      self.trabalho = trab_field.read
    end
  end

  def apresentacoes=(apres_field)
    self.nomeApres = ""
    unless apres_field.instance_of?(''.class)
      self.apresCntType = apres_field.content_type
      self.nomeApres = apres_field.original_filename
      self.apresentacao = apres_field.read
    end
  end

  protected

  def validate
    # Valida content-type do trabalho (DOC)
    if self.nomeTrab.length > 0 and self.trabCntType !~ /^application\/msword/
      errors.add(:trabalho, "O trabalho deve ser um arquivo do tipo DOC! Foi enviado #{self.trabCntType} (#{self.nomeTrab}).")
    end
    # Valida content-type da apresentação (PPT)
    if self.nomeApres.length > 0 and self.apresCntType !~ /^application\/vnd\.ms-powerpoint/
      errors.add(:apresentacao, "A apresentação deve ser um arquivo do tipo PPT! Foi enviado #{self.apresCntType} (#{self.nomeApres}).")
    end
  end
end
