class ManualController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getManual', 'list']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getManual],
         :redirect_to => { :action => :list }

  def list
    @manual_pages, @manuals = paginate :manuals, :per_page => numberOfPages, :order => "titulo"
  end

  def new
    @manual = Manual.new
  end

  def create
    begin
      @manual = Manual.new(params[:manual])
      if @manual.save
        flash[:message] = 'Manual criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do manual não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do manual não efetuado. Erro: 'Erro no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Manual.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de manual não efetuada. Erro: 'Erro no Banco de Dados'..."
    else
      flash[:message] = 'Manual excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end

  def getManual
    @manual = Manual.find(params[:id])
    send_data(@manual.anexo, :filename => "#{@manual.nome}")
  end
end
