class DadoAcademico < ActiveRecord::Base
  belongs_to :user
  belongs_to :turma
  belongs_to :escolaridade
  has_and_belongs_to_many :area_interesses
  has_and_belongs_to_many :linha_pesquisas

  validates_presence_of :user_id, :turma_id, :escolaridade_id, :instituicao, :matricula, :especialidade, :periodo, :datainicio, :datatermino, :titulo, :horario, :orientadorexterno, :orientadorinterno
  validates_length_of :instituicao, :within => 3..100
  validates_length_of :matricula, :within => 3..20
  validates_numericality_of :periodo, :only_integer => true, :greater_than => 0
  validates_inclusion_of :periodo, :in => 1..50, :message => "deve ser um inteiro entre 1 e 50."
  validates_date :datainicio, :before => :datatermino
  validates_date :datatermino, :after => :datainicio

  attr_protected :id
end
