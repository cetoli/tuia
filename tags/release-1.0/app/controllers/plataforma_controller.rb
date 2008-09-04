class PlataformaController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :new ],
         :redirect_to => { :action => :list }

  def list
    @plataforma_pages, @plataformas = paginate :plataformas, :per_page => numberOfPages, :order => "nome"
  end

  def new
    @plataforma = Plataforma.new
  end

  def create
    begin
      @plataforma = Plataforma.new(params[:plataforma])
      if @plataforma.save
        flash[:message] = 'Plataforma criada com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento da plataforma n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da plataforma n�o efetuado. Erro: 'Plataforma j� existe'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Plataforma.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de plataforma n�o efetuada. Erro: 'Plataforma est� sendo usada por algum usu�rio. Remova esta refer�ncia antes de excluir a plataforma'..."
    else
      flash[:message] = 'Plataforma exclu�da com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
