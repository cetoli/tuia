class DadoAcademicoController < ApplicationController
  layout "tuia"

  before_filter :set_charset

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create, :update ],
         :redirect_to => { :controller => :user, :action => :index }

  def new
    unless session[:new_user]
      flash[:warning] = "Cadastre-se na plataforma..."
      redirect_to :controller => :user, :action => 'signup'
    else
      @dadoAcademico = DadoAcademico.new
      @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
      flash[:message] = 'Por favor, preencha os dados abaixo para completar sua inscrição.'
    end
  end

  def create
    begin
      unless session[:new_user]
        flash[:warning] = "Cadastre-se na plataforma..."
        redirect_to :controller => :user, :action => 'signup'
      else
        @dadoAcademico = DadoAcademico.new(params[:dadoAcademico])
        @dadoAcademico.user_id = 0
        if @dadoAcademico.valid?
          DadoAcademico.transaction do
            session[:new_user].save
            @dadoAcademico.user_id = session[:new_user].id
            @dadoAcademico.save
          end
          Notifications.deliver_userApproval('adm.tuia@gmail.com', session[:new_user].nome, session[:new_user].email)
          session[:new_user] = nil
          flash[:message] = 'Cadastramento efetuado com sucesso! Aguarde confirmação sobre sua aprovação.'
          redirect_to :controller => :user, :action => 'about'
        else
          @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
          flash[:warning] = "Cadastramento não efetuado..."
          render :action => 'new'
        end
      end
    rescue  Timeout::Error
      session[:new_user] = nil
      flash[:warning] = "Problemas no envio de e-mail de aprovação. Erro: 'Tempo de operação esgotado'..."
      redirect_to :controller => :user, :action => 'about'
    rescue ActiveRecord::StatementInvalid
      session[:new_user] = nil
      flash[:warning] = "Problemas no banco de dados, por favor tente novamente mais tarde."
      redirect_to :controller => :user, :action => 'signup'
    end
  end

  def edit
    @dadoAcademico = DadoAcademico.find(:first, :conditions => ['user_id = :user_id', {:user_id => params[:id]}])
    @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
    @user_id = params[:id]
  end

  def update
    @dadoAcademico = DadoAcademico.find(params[:id])
    if @dadoAcademico.update_attributes(params[:dadoAcademico])
      flash[:message] = 'Usuário alterado com sucesso!'
      redirect_to :controller => :user, :action => 'show', :id => @dadoAcademico.user_id
    else
      @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
      @user_id = @dadoAcademico.user_id
      flash[:warning] = "Problemas na alteração do usuário..."
      render :action => 'edit'
    end
  end
end
