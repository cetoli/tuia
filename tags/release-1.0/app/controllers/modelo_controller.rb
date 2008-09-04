class ModeloController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getModelo', 'list']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getModelo],
         :redirect_to => { :action => :list }

  def list
    @modelo_pages, @modelos = paginate :modelos, :per_page => numberOfPages, :order => "titulo"
  end

  def new
    @modelo = Modelo.new
  end

  def create
    begin
      @modelo = Modelo.new(params[:modelo])
      if @modelo.save
        flash[:message] = 'Modelo criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do modelo não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do modelo não efetuado. Erro: 'Erro no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Modelo.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de modelo não efetuada. Erro: 'Erro no Banco de Dados'..."
    else
      flash[:message] = 'Modelo excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end

  def getModelo
    @modelo = Modelo.find(params[:id])
    send_data(@modelo.anexo, :filename => "#{@modelo.nome}")
  end
end
