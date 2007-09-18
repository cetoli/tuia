class Notifications < ActionMailer::Base

  def userApproval(to, sent_at = Time.now)
    @subject    = '[T.U.I.A.] - Aprovação de Usuário'
    @body       = {}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end

  def docApproval(to, sent_at = Time.now)
    @subject    = '[T.U.I.A.] - Aprovação de Documento'
    @body       = {}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end

  def userAcceptance(to, sent_at = Time.now)
    @subject    = '[T.U.I.A.] - Bem Vindo à Plataforma TUIA'
    @body       = {}
    @recipients = to
    @from       = 'adm.tuia@ufrj.br'
    @sent_on    = sent_at
    @headers    = {}
    @charset    = 'ISO-8859-1'
  end
end
