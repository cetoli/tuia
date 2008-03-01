class DadoAcademicoController < ApplicationController
  layout "tuia"

  before_filter :set_charset

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :controller => :user, :action => :index }

  def new
    @dadoAcademico = DadoAcademico.new
    @turmas = Turma.find_all.collect{ |t| [t.nome, t.id] }
    @user_id = params[:id]
  end

  def create
    begin
      @dadoAcademico = DadoAcademico.new(params[:dadoAcademico])
      @dadoAcademico.user_id = params[:user_id]
      if @dadoAcademico.save
        flash[:message] = 'Cadastramento efetuado com sucesso! Aguarde confirma��o sobre sua aprova��o.'
        redirect_to :controller => :user, :action => :list
      else
        @turmas = Turma.find_all.collect{ |t| [t.nome, t.id] }
        @user_id = params[:user_id]
        flash[:warning] = "Cadastramento n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      @turmas = Turma.find_all.collect{ |t| [t.nome, t.id] }
      @user_id = params[:user_id]
      flash[:warning] = "Cadastramento do usu�rio n�o efetuado. Erro: 'Problemas com o banco de dados'..."
      render :action => 'new'
    end
  end

  def edit
    @dadoAcademico = DadoAcademico.find(:first, :conditions => ['user_id = :user_id', {:user_id => params[:id]}])
    @turmas = Turma.find_all.collect{ |t| [t.nome, t.id] }
    @user_id = params[:id]
  end

  def update
    @dadoAcademico = DadoAcademico.find(params[:id])
    if @dadoAcademico.update_attributes(params[:dadoAcademico])
      flash[:message] = 'Usu�rio alterado com sucesso!'
      redirect_to :controller => :user, :action => 'show', :id => @dadoAcademico.user_id
    else
      @turmas = Turma.find_all.collect{ |t| [t.nome, t.id] }
      @user_id = @dadoAcademico.user_id
      flash[:warning] = "Problemas na altera��o do usu�rio..."
      render :action => 'edit'
    end
  end
end
