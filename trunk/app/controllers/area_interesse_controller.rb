class AreaInteresseController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :list }

  def list
    @areaInteresse_pages, @areaInteresse = paginate :areaInteresse, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @areaInteresse = AreaInteresse.find(params[:id])
  end

  def new
    @areaInteresse = AreaInteresse.new
  end

  def create
    begin
      @areaInteresse = AreaInteresse.new(params[:areaInteresse])
      if @areaInteresse.save
        flash[:message] = '�rea de Interesse criada com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento da �rea de interesse n�o efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento da �rea de interesse n�o efetuado. Erro: '�rea de Interesse j� existe'..."
      render :action => 'new'
    end
  end

  def edit
    @areaInteresse = AreaInteresse.find(params[:id])
  end

  def update
    @areaInteresse = AreaInteresse.find(params[:id])
    if @areaInteresse.update_attributes(params[:areaInteresse])
      flash[:message] = '�rea de Interesse alterada com sucesso!'
      redirect_to :action => 'show', :id => @areaInteresse
    else
      flash[:warning] = "Problemas na altera��o da �rea de interesse..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      AreaInteresse.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de �rea de interesse n�o efetuada. Erro: '�rea de Interesse est� sendo usada por algum usu�rio. Remova esta refer�ncia antes de excluir a �rea de interesse'..."
    else
      flash[:message] = '�rea de Interesse exclu�da com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
