class LinhaPesquisaController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['showLinhaPesquisa']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @linhaPesquisa_pages, @linhaPesquisas = paginate :linhaPesquisas, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @linhaPesquisa = LinhaPesquisa.find(params[:id])
  end

  def new
    @linhaPesquisa = LinhaPesquisa.new
  end

  def create
    begin
      @linhaPesquisa = LinhaPesquisa.new(params[:linhaPesquisa])
      if @linhaPesquisa.save
        flash[:message] = 'Linha de Pesquisa criada com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento da linha de pesquisa n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da linha de pesquisa n�o efetuado. Erro: 'Linha de Pesquisa j� existe'..."
      render :action => 'new'
    end
  end

  def edit
    @linhaPesquisa = LinhaPesquisa.find(params[:id])
  end

  def update
    @linhaPesquisa = LinhaPesquisa.find(params[:id])
    if @linhaPesquisa.update_attributes(params[:linhaPesquisa])
      flash[:message] = 'Linha de Pesquisa alterada com sucesso!'
      redirect_to :action => 'show', :id => @linhaPesquisa
    else
      flash[:warning] = "Problemas na altera��o da linha de pesquisa..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      LinhaPesquisa.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de linha de pesquisa n�o efetuada. Erro: 'Linha de Pesquisa est� sendo usada por algum usu�rio. Remova esta refer�ncia antes de excluir a linha de pesquisa'..."
    else
      flash[:message] = 'Linha de Pesquisa exclu�da com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end

  def showLinhaPesquisa
    @linhaPesquisa = LinhaPesquisa.find(params[:id])
    send_data(@linhaPesquisa.anexo, :filename => "#{@linhaPesquisa.nomeAnexo}")
  end
end
