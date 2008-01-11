class Notifications < ActionMailer::Base

  def userApproval(to, nome, email, sent_at = Time.now)
    @subject    = '[T.U.I.A.] - Aprovação de Usuário'
    @body       = {:nome => nome, :email => email}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end

  def docApproval(to, title, creation, modification, author, sent_at = Time.now)
    @subject    = '[T.U.I.A.] - Aprovação de Documento'
    @body       = {:title => title, :creation => creation, :modification => modification, :author => author}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end

  def userAcceptance(to, nome, login, sent_at = Time.now)
    @subject    = '[T.U.I.A.] - Bem Vindo à Plataforma TUIA'
    @body       = {:nome => nome, :login => login}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end
  
  def forgot_password(to, nome, login, pass, sent_at = Time.now)
    @subject    = "[T.U.I.A.] - Sua senha é..."
    @body       = {:nome => nome, :login => login, :pass => pass}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end
end
