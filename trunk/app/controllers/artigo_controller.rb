class ArtigoController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getArtigo']

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getArtigo, :show ],
         :redirect_to => { :action => :list }

  def list
    @artigo_pages, @artigos = paginate :artigos, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @artigo = Artigo.find(params[:id])
  end

  def new
    @artigo = Artigo.new
  end

  def create
    begin
      @artigo = Artigo.new(params[:artigo])
      @artigo.usado = false
      if @artigo.save
        flash[:message] = 'Artigo criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do artigo n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do artigo n�o efetuado. Erro: 'Artigo j� existente no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Artigo.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de artigo n�o efetuada. Erro: 'Artigo est� sendo usado em algum documento. Remova este documento antes de excluir o artigo'..."
    else
      flash[:message] = 'Artigo exclu�do com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
  
  def getArtigo
    @artigo = Artigo.find(params[:id])
    send_data(@artigo.anexo, :filename => "#{@artigo.nome}")
  end
end
