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
      flash[:message] = '�rea criada com sucesso!'
      redirect_to :action => 'list'
    else
      flash[:warning] = "Cadastramento de �rea n�o efetuado..."
      render :action => 'new'
    end
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    @area = Area.find(params[:id])
    if @area.update_attributes(params[:area])
      flash[:message] = '�rea alterada com sucesso!'
      redirect_to :action => 'show', :id => @area
    else
      flash[:warning] = "Altera��o de �rea n�o efetuada..."
      render :action => 'edit'
    end
  end

  def destroy
    Area.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def listar
    @area_pages, @areas = paginate :areas, :per_page => numberOfPages
  end
end
