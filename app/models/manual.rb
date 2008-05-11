class Manual < ActiveRecord::Base
  validates_presence_of :nome, :titulo
  validates_uniqueness_of :nome, :titulo

  attr_protected :id, :nome, :anexo

  def anexos=(anex_field)
    unless anex_field.instance_of?(''.class)
      self.nome = anex_field.original_filename
      self.anexo = anex_field.read
    end
  end
end
