class ArtigoController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getArtigo', 'getResumo', 'listar', 'novo']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getResumo, :getArtigo, :show ],
         :redirect_to => { :action => :list }

  def novo
    @artigo_id = params[:id]
    @artigo_nome = params[:nome]
    @areas = Area.find(:all).collect{ |c| [c.codigo, c.id] }
  end

  def listar
    @artigo_pages, @artigos = paginate :artigos, :per_page => numberOfPages, :conditions => ['usado = :usado', {:usado => false}], :order => "nome"
  end

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
      if @artigo.isresumo
        @artigo.resumo = @artigo.anexo
        @artigo.anexo = nil
      end
      @artigo.usado = false
      if @artigo.save
        flash[:message] = 'Artigo criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do artigo não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do artigo não efetuado. Erro: 'Erro no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Artigo.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de artigo não efetuada. Erro: 'Artigo está sendo usado em algum documento. Remova este documento antes de excluir o artigo'..."
    else
      flash[:message] = 'Artigo excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
  
  def getArtigo
    @artigo = Artigo.find(params[:id])
    send_data(@artigo.anexo, :filename => "#{@artigo.nome}")
  end
  
  def getResumo
    @artigo = Artigo.find(params[:id])
    send_data(@artigo.resumo, :filename => "#{@artigo.nome}")
  end
end
