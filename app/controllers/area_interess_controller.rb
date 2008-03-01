class AreaInteressController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @areaInteress_pages, @areaInteresses = paginate :areaInteresses, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @areaInteress = AreaInteress.find(params[:id])
  end

  def new
    @areaInteress = AreaInteress.new
  end

  def create
    begin
      @areaInteress = AreaInteress.new(params[:areaInteress])
      if @areaInteress.save
        flash[:message] = 'Área de Interesse criada com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento da área de interesse não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da área de interesse não efetuado. Erro: 'Área de Interesse já existe'..."
      render :action => 'new'
    end
  end

  def edit
    @areaInteress = AreaInteress.find(params[:id])
  end

  def update
    @areaInteress = AreaInteress.find(params[:id])
    if @areaInteress.update_attributes(params[:areaInteress])
      flash[:message] = 'Área de Interesse alterada com sucesso!'
      redirect_to :action => 'show', :id => @areaInteress
    else
      flash[:warning] = "Problemas na alteração da área de interesse..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      AreaInteress.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de área de interesse não efetuada. Erro: 'Área de Interesse está sendo usada por algum usuário. Remova esta referência antes de excluir a área de interesse'..."
    else
      flash[:message] = 'Área de Interesse excluída com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
