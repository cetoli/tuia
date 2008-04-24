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
      flash[:message] = 'Por favor, preencha os dados abaixo para completar sua inscri��o.'
    end
  end

  def create
    begin
      user = session[:new_user]
      unless user
        flash[:warning] = "Cadastre-se na plataforma..."
        redirect_to :controller => :user, :action => 'signup'
      else
        @dadoAcademico = DadoAcademico.new(params[:dadoAcademico])
        @dadoAcademico.user_id = 0
        if @dadoAcademico.valid?
          if user.save
            @dadoAcademico.user_id = user.id
            if @dadoAcademico.save
              Notifications.deliver_userApproval('adm.tuia@gmail.com', user.nome, user.email)
              session[:new_user] = nil
              flash[:message] = 'Cadastramento efetuado com sucesso! Aguarde confirma��o sobre sua aprova��o.'
              redirect_to :controller => :user, :action => 'about'
            else
              User.find(user.id).destroy
              @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
              flash[:warning] = "Cadastramento n�o efetuado..."
              render :action => 'new'
            end
          else
            @cadastros = Cadastro.find(:all).collect{ |t| [t.nome, t.id] }
            session[:new_user] = nil
            flash[:warning] = "Cadastramento n�o efetuado..."
            redirect_to :controller => :user, :action => 'signup'
          end
        else
          @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
          flash[:warning] = "Cadastramento n�o efetuado..."
          render :action => 'new'
        end
      end
    rescue  Timeout::Error
      session[:new_user] = nil
      flash[:warning] = "Problemas no envio de e-mail de aprova��o. Erro: 'Tempo de opera��o esgotado'..."
      redirect_to :controller => :user, :action => 'about'
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
      flash[:message] = 'Usu�rio alterado com sucesso!'
      redirect_to :controller => :user, :action => 'show', :id => @dadoAcademico.user_id
    else
      @turmas = Turma.find(:all).collect{ |t| [t.nome, t.id] }
      @user_id = @dadoAcademico.user_id
      flash[:warning] = "Problemas na altera��o do usu�rio..."
      render :action => 'edit'
    end
  end
end
