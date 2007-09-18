class AreaController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['listar']

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @area_pages, @areas = paginate :areas, :per_page => numberOfPages
  end

  def show
    @area = Area.find(params[:id])
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(params[:area])
    if @area.save
      flash[:message] = 'Área criada com sucesso!'
      redirect_to :action => 'list'
    else
      flash[:warning] = "Cadastramento de área não efetuado..."
      render :action => 'new'
    end
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    @area = Area.find(params[:id])
    if @area.update_attributes(params[:area])
      flash[:message] = 'Área alterada com sucesso!'
      redirect_to :action => 'show', :id => @area
    else
      flash[:warning] = "Alteração de área não efetuada..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      Area.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de área não efetuada. Erro: 'Área possui documento(s) aprovado(s) ou pendente(s) de aprovação. Remova estes documentos antes de excluir a área'..."
    else
      flash[:message] = 'Área excluída com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end

  def listar
    @area_pages, @areas = paginate :areas, :per_page => numberOfPages
  end
end
