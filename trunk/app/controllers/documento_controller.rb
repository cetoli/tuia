class DocumentoController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getDocsArea', 'getAnexo', 'mostrar', 'novo', 'editar', 'updateUsr', 'createUsr']

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :updateUsr, :createUsr, :getAnexo, :mostrar, :aprovar, :editar, :novo ],
         :redirect_to => { :action => :list }

  def list
    @documento_pages, @documentos = paginate :documentos, :per_page => numberOfPages
  end

  def show
    @documento = Documento.find(params[:id])
  end

  def new
    @documento = Documento.new
    @users = User.find_all.collect{ |t| [t.login, t.id] }
    @areas = Area.find_all.collect{ |c| [c.codigo, c.id] }
  end

  def create
    @documento = Documento.new(params[:documento])
    @documento.criado = @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    @documento.aprovado = false
    if @documento.save
      flash[:message] = 'Documento criado com sucesso!'
      Notifications.deliver_docApproval('adm.tuia@gmail.com')
      redirect_to :action => 'list'
    else
      flash[:warning] = "Cadastramento do documento não efetuado..."
      render :action => 'new'
    end
  end

  def edit
    @documento = Documento.find(params[:id])
    @users = User.find_all.collect{ |t| [t.login, t.id] }
    @areas = Area.find_all.collect{ |c| [c.codigo, c.id] }
  end

  def update
    @documento = Documento.find(params[:id])
    @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    @documento.aprovado = false
    if @documento.update_attributes(params[:documento])
      flash[:message] = 'Documento alterado com sucesso!'
      Notifications.deliver_docApproval('adm.tuia@gmail.com')
      redirect_to :action => 'show', :id => @documento
    else
      flash[:warning] = "Alteração do documento não efetuado..."
      render :action => 'edit'
    end
  end

  def destroy
    Documento.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def aprovar
    @documento = Documento.find(params[:id])
    @documento.aprovado = true
    if @documento.update
      flash[:message] = 'Documento aprovado com sucesso!'
      redirect_to :action => 'show', :id => @documento
    else
      flash[:warning] = "Aprovação do documento não efetuada..."
      render :action => 'show', :id => @documento
    end
  end

  def mostrar
    @documento = Documento.find(params[:id])
  end

  def novo
    @documento = Documento.new
    @user_id = current_user.id
    @area_id = params[:id]
  end

  def editar
    @documento = Documento.find(params[:id])
  end

  def updateUsr
    @documento = Documento.find(params[:id])
    @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    @documento.aprovado = false
    if @documento.update_attributes(params[:documento])
      flash[:message] = 'Documento alterado com sucesso!'
      Notifications.deliver_docApproval('adm.tuia@gmail.com')
      redirect_to :action => 'getDocsArea', :id => @documento.area
    else
      flash[:warning] = "Alteração do documento não efetuado..."
      render :action => 'editar'
    end
  end

  def createUsr
    @documento = Documento.new(params[:documento])
    @documento.user_id = params[:user_id]
    @documento.area_id = params[:area_id]
    @documento.criado = @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
    @documento.aprovado = false
    if @documento.save
      flash[:message] = 'Documento criado com sucesso!'
      Notifications.deliver_docApproval('adm.tuia@gmail.com')
      redirect_to :action => 'getDocsArea', :id => @documento.area
    else
      flash[:warning] = "Cadastramento do documento não efetuado..."
      render :action => 'novo'
    end
  end

  def getDocsArea
    @documento_pages, @documentos = paginate :documentos, :conditions => { :area_id => params[:id], :aprovado => true }, :per_page => numberOfPages
    @area = params[:area]
    @idArea = params[:id]
    render :action => 'listar'
  end

  def getAnexo
    @documento = Documento.find(params[:id])
    send_data(@documento.anexo, :filename => "#{@documento.nome}")
  end
end
