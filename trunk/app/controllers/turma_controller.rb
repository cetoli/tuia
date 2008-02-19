class TurmaController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @turma_pages, @turmas = paginate :turmas, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @turma = Turma.find(params[:id])
  end

  def new
    @turma = Turma.new
  end

  def create
    begin
      @turma = Turma.new(params[:turma])
      if @turma.save
        flash[:message] = 'Turma criada com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento da turma n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da turma n�o efetuado. Erro: 'Turma j� existe'..."
      render :action => 'new'
    end
  end

  def edit
    @turma = Turma.find(params[:id])
  end

  def update
    @turma = Turma.find(params[:id])
    if @turma.update_attributes(params[:turma])
      flash[:message] = 'Turma alterada com sucesso!'
      redirect_to :action => 'show', :id => @turma
    else
      flash[:warning] = "Problemas na altera��o da turma..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Turma.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de turma n�o efetuada. Erro: 'Turma est� sendo usada por algum usu�rio. Remova esta refer�ncia antes de excluir a turma'..."
    else
      flash[:message] = 'Turma exclu�da com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
