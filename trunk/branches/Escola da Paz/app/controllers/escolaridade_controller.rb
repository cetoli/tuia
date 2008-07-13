class EscolaridadeController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @escolaridade_pages, @escolaridades = paginate :escolaridades, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @escolaridade = Escolaridade.find(params[:id])
  end

  def new
    @escolaridade = Escolaridade.new
  end

  def create
    begin
      @escolaridade = Escolaridade.new(params[:escolaridade])
      if @escolaridade.save
        flash[:message] = 'Escolaridade criada com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento da escolaridade não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da escolaridade não efetuado. Erro: 'Escolaridade já existe'..."
      render :action => 'new'
    end
  end

  def edit
    @escolaridade = Escolaridade.find(params[:id])
  end

  def update
    @escolaridade = Escolaridade.find(params[:id])
    if @escolaridade.update_attributes(params[:escolaridade])
      flash[:message] = 'Escolaridade alterada com sucesso!'
      redirect_to :action => 'show', :id => @escolaridade
    else
      flash[:warning] = "Problemas na alteração da escolaridade..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Escolaridade.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de escolaridade não efetuada. Erro: 'Escolaridade está sendo usada por algum usuário. Remova esta referência antes de excluir a escolaridade'..."
    else
      flash[:message] = 'Escolaridade excluída com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
