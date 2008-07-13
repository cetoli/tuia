class CadastroController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @cadastro_pages, @cadastros = paginate :cadastros, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @cadastro = Cadastro.find(params[:id])
  end

  def new
    @cadastro = Cadastro.new
  end

  def create
    begin
      @cadastro = Cadastro.new(params[:cadastro])
      if @cadastro.save
        flash[:message] = 'Tipo de cadastro criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do tipo de cadastro não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do tipo de cadastro não efetuado. Erro: 'Tipo de cadastro já existe'..."
      render :action => 'new'
    end
  end

  def edit
    @cadastro = Cadastro.find(params[:id])
  end

  def update
    @cadastro = Cadastro.find(params[:id])
    if @cadastro.update_attributes(params[:cadastro])
      flash[:message] = 'Tipo de cadastro alterado com sucesso!'
      redirect_to :action => 'show', :id => @cadastro
    else
      flash[:warning] = "Problemas na alteração do tipo de cadastro..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Cadastro.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão do tipo de cadastro não efetuada. Erro: 'Tipo de cadastro está sendo usado por algum usuário. Remova esta referência antes de excluir o tipo de cadastro'..."
    else
      flash[:message] = 'Tipo de cadastro excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
