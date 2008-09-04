class ProjetoController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getPrjsArea', 'getSituacao', 'getAnexo', 'getApresentacao', 'mostrar', 'novo', 'editar', 'updateUsr', 'createUsr']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :updateUsr, :createUsr, :getSituacao, :getAnexo, :getApresentacao, :mostrar, :aprovar, :editar, :novo ],
         :redirect_to => { :action => :list }

  def list
    @projeto_pages, @projetos = paginate :projetos, :per_page => numberOfPages, :order => "titulo"
  end

  def show
    @projeto = Projeto.find(params[:id])
  end

  def new
    @projeto = Projeto.new
    @users = User.find(:all).collect{ |t| [t.login, t.id] }
    @areas = Area.find(:all, :conditions => ['projeto = :projeto', {:projeto => true}], :order => "codigo").collect{ |c| [c.codigo, c.id] }
    @show = true
  end

  def create
    begin
      @projeto = Projeto.new(params[:projeto])
      @projeto.criado = @projeto.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @projeto.aprovado = false
      if (@projeto.save)
        flash[:message] = 'Projeto criado com sucesso!'
        Notifications.deliver_prjApproval('adm.tuia@gmail.com', @projeto.titulo, @projeto.criado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.user.nome)
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do projeto não efetuado..."
        @users = User.find(:all).collect{ |t| [t.login, t.id] }
        @areas = Area.find(:all, :conditions => ['projeto = :projeto', {:projeto => true}]).collect{ |c| [c.codigo, c.id] }
        @show = true
        render :action => 'new'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'list'
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do projeto não efetuado. Erro: 'Erro no Banco de Dados'..."
      @users = User.find(:all).collect{ |t| [t.login, t.id] }
      @areas = Area.find(:all, :conditions => ['projeto = :projeto', {:projeto => true}]).collect{ |c| [c.codigo, c.id] }
      @show = true
      render :action => 'new'
    end
  end

  def edit
    @projeto = Projeto.find(params[:id])
    @areas = Area.find(:all, :conditions => ['projeto = :projeto', {:projeto => true}]).collect{ |c| [c.codigo, c.id] }
    @show = false
  end

  def update
    begin
      @projeto = Projeto.find(params[:id])
      @projeto.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @projeto.aprovado = false
      if @projeto.update_attributes(params[:projeto])
        flash[:message] = 'Projeto alterado com sucesso!'
        Notifications.deliver_prjApproval('adm.tuia@gmail.com', @projeto.titulo, @projeto.criado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.user.nome)
        redirect_to :action => 'show', :id => @projeto
      else
        flash[:warning] = "Alteração do projeto não efetuada..."
        render :action => 'edit'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'show', :id => @projeto
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do projeto não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'show', :id => @projeto
    end
  end

  def destroy
    Projeto.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def aprovar
    @projeto = Projeto.find(params[:id])
    @projeto.aprovado = true
    if @projeto.update
      flash[:message] = 'Projeto aprovado com sucesso!'
      redirect_to :action => 'show', :id => @projeto
    else
      flash[:warning] = "Aprovação do projeto não efetuada..."
      render :action => 'show', :id => @projeto
    end
  end

  def mostrar
    @projeto = Projeto.find(params[:id])
    @area = params[:area]
  end

  def novo
    @projeto = Projeto.new
    @user_id = current_user.id
    @area_id = params[:id]
    @area = params[:area]
  end

  def editar
    @projeto = Projeto.find(params[:id])
    @area = params[:area]
  end

  def updateUsr
    begin
      @projeto = Projeto.find(params[:id])
      @projeto.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @projeto.aprovado = false
      @area = params[:area]
      if @projeto.update_attributes(params[:projeto])
        flash[:message] = 'Projeto alterado com sucesso!'
        Notifications.deliver_prjApproval('adm.tuia@gmail.com', @projeto.titulo, @projeto.criado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.user.nome)
        redirect_to :action => 'getPrjsArea', :id => @projeto.area
      else
        flash[:warning] = "Alteração do projeto não efetuada..."
        render :action => 'editar'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getPrjsArea', :id => @projeto.area
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do projeto não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'getPrjsArea', :id => @projeto.area
    end
  end

  def createUsr
    begin
      @projeto = Projeto.new(params[:projeto])
      @projeto.user_id = params[:user_id]
      @projeto.area_id = params[:area_id]
      @projeto.criado = @projeto.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @projeto.aprovado = false
      if (@projeto.save)
        flash[:message] = 'Projeto criado com sucesso!'
        Notifications.deliver_prjApproval('adm.tuia@gmail.com', @projeto.titulo, @projeto.criado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @projeto.user.nome)
        redirect_to :action => 'getPrjsArea', :id => @projeto.area
      else
        flash[:warning] = "Cadastramento do projeto não efetuado..."
        @user_id = current_user.id
        @area_id = params[:area_id]
        @area = params[:area]
        @show = true
        render :action => 'novo'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getPrjsArea', :id => @projeto.area
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do projeto não efetuada. Erro: 'Erro no Banco de Dados'..."
      redirect_to :action => 'mostrar', :id => @projeto
    end
  end

  def getPrjsArea
    @projeto_pages, @projetos = paginate :projetos, :conditions => { :area_id => params[:id], :aprovado => true }, :per_page => numberOfPages, :order => "titulo"
    @area = params[:area]
    @idArea = params[:id]
    render :action => 'listar'
  end

  def getAnexo
    @projeto = Projeto.find(params[:id])
    send_data(@projeto.anexo, :filename => "#{@projeto.nome}")
  end

  def getSituacao
    @projeto = Projeto.find(params[:id])
    send_data(@projeto.situacao, :filename => "#{@projeto.nome_situacao}")
  end

  def getApresentacao
    @projeto = Projeto.find(params[:id])
    send_data(@projeto.apresentacao, :filename => "#{@projeto.nome_apresentacao}")
  end
end
