class SeminarioController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getSemsArea', 'getDoc', 'getPpt', 'novo', 'createUsr']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getDoc, :getPpt ],
         :redirect_to => { :action => :list }

  def list
    @seminario_pages, @seminarios = paginate :seminarios, :per_page => numberOfPages, :order => "titulo"
  end

  def show
    @seminario = Seminario.find(params[:id])
  end

  def new
    @seminario = Seminario.new
    @users = User.find(:all).collect{ |t| [t.login, t.id] }
    @areas = Area.find(:all, :conditions => ['seminario = :seminario', {:seminario => true}]).collect{ |c| [c.codigo, c.id] }
  end

  def create
    begin
      @seminario = Seminario.new(params[:seminario])
      @seminario.criado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @seminario.aprovado = false
      if @seminario.save
        flash[:message] = 'Semin�rio criado com sucesso!'
        Notifications.deliver_semApproval('adm.tuia@gmail.com', @seminario.titulo, @seminario.criado.strftime("%d/%m/%Y - %H:%M:%S"), @seminario.user.nome)
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do semin�rio n�o efetuado..."
        @users = User.find(:all).collect{ |t| [t.login, t.id] }
        @areas = Area.find(:all, :conditions => ['seminario = :seminario', {:seminario => true}]).collect{ |c| [c.codigo, c.id] }
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do semin�rio n�o efetuado. Erro: 'Erro no Banco de Dados'..."
      @users = User.find(:all).collect{ |t| [t.login, t.id] }
      @areas = Area.find(:all, :conditions => ['seminario = :seminario', {:seminario => true}]).collect{ |c| [c.codigo, c.id] }
      render :action => 'new'
    rescue Timeout::Error
      flash[:warning] = "E-mail de notifica��o n�o enviado. Erro: 'Tempo de opera��o esgotado'..."
      redirect_to :action => 'list'
    end
  end

  def destroy
    begin
      Seminario.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de semin�rio n�o efetuada. Erro: 'Erro no Banco de Dados'..."
    else
      flash[:message] = 'Semin�rio exclu�do com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
  
  def aprovar
    @seminario = Seminario.find(params[:id])
    @seminario.aprovado = true
    if @seminario.update
      flash[:message] = 'Semin�rio aprovado com sucesso!'
      redirect_to :action => 'list'
    else
      flash[:warning] = "Aprova��o do semin�rio n�o efetuada..."
      render :action => 'list'
    end
  end

  def getPpt
    @seminario = Seminario.find(params[:id])
    send_data(@seminario.apresentacao, :filename => "#{@seminario.nomeApres}")
  end
  
  def getDoc
    @seminario = Seminario.find(params[:id])
    send_data(@seminario.trabalho, :filename => "#{@seminario.nomeTrab}")
  end

  def getSemsArea
    @seminario_pages, @seminarios = paginate :seminarios, :conditions => { :area_id => params[:id], :aprovado => true }, :per_page => numberOfPages, :order => "titulo"
    @area = params[:area]
    @idArea = params[:id]
    render :action => 'listar'
  end

  def novo
    @seminario = Seminario.new
    @user_id = current_user.id
    @area_id = params[:id]
    @area = params[:area]
  end
  
  def createUsr
    begin
      @seminario = Seminario.new(params[:seminario])
      @seminario.criado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @seminario.aprovado = false
      @seminario.user_id = params[:user_id]
      @seminario.area_id = params[:area_id]
      if @seminario.save
        flash[:message] = 'Semin�rio criado com sucesso!'
        Notifications.deliver_semApproval('adm.tuia@gmail.com', @seminario.titulo, @seminario.criado.strftime("%d/%m/%Y - %H:%M:%S"), @seminario.user.nome)
        redirect_to :action => 'getSemsArea', :area => @seminario.area.codigo, :id => @seminario.area_id
      else
        flash[:warning] = "Cadastramento do semin�rio n�o efetuado..."
        @user_id = current_user.id
        @area_id = params[:area_id]
        @area = params[:area]
        render :action => 'novo'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do semin�rio n�o efetuado. Erro: 'Erro no Banco de Dados'..."
      @user_id = current_user.id
      @area_id = params[:area_id]
      @area = params[:area]
      render :action => 'novo'
    rescue Timeout::Error
      flash[:warning] = "E-mail de notifica��o n�o enviado. Erro: 'Tempo de opera��o esgotado'..."
      redirect_to :action => 'getSemsArea', :area => @seminario.area.codigo, :id => @seminario.area_id
    end
  end
end
