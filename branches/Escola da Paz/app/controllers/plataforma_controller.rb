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
        flash[:warning] = "Cadastramento da plataforma não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da plataforma não efetuado. Erro: 'Plataforma já existe'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Plataforma.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de plataforma não efetuada. Erro: 'Plataforma está sendo usada por algum usuário. Remova esta referência antes de excluir a plataforma'..."
    else
      flash[:message] = 'Plataforma excluída com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
