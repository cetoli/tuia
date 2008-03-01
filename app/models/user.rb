require 'digest/sha1'

class User < ActiveRecord::Base
  belongs_to :cadastro
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :plataformas
  has_many :documentos
  has_many :dado_academicos

  validates_length_of :nome, :within => 3..50
  validates_length_of :login, :within => 5..10
  validates_length_of :senha, :within => 5..10
  validates_length_of :email, :maximum => 45
  validates_length_of :nacionalidade, :within => 3..50
  validates_length_of :naturalidade, :within => 3..100
  validates_length_of :bairro, :within => 3..50
  validates_length_of :cep, :is => 10
  validates_length_of :telefone, :is => 13
  validates_length_of :celular, :is => 13
  validates_presence_of :nome, :login, :senha, :senha_confirmation, :salt, :email, :sexo, :nacionalidade, :naturalidade, :bairro, :cep, :telefone, :celular, :endereco
  validates_date :datanascimento, :before => Date.today, :before_message => 'deve ser anterior a hoje!'
  validates_uniqueness_of :login, :email
  validates_confirmation_of :senha
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "E-mail inválido!"

  attr_protected :id, :salt, :aprovado
  attr_accessor :senha, :senha_confirmation

  def self.authenticate(login, passw)
    u = find(:first, :conditions => { :login => login, :aprovado => true })
    return nil if u.nil?
    return u if User.encrypt(passw, u.salt) == u.pass
    nil
  end

  def senha=(passw)
    @senha = passw
    self.salt = User.random_string(10) if !self.salt?
    self.pass = User.encrypt(@senha, self.salt)
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.senha = self.confirmacao_senha = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.nome, self.login, new_pass)
  end

  protected

  def self.encrypt(passw, salt)
    Digest::SHA1.hexdigest(passw + salt)
  end
 
  def self.random_string(len)
    # generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size - 1)] }
    return newpass
  end
end
