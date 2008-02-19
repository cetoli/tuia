class DocumentoController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['getDocsArea', 'getAnexo', 'mostrar', 'novo', 'editar', 'updateUsr', 'createUsr', 'createUsrArt']

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :updateUsr, :createUsr, :createUsrArt, :getAnexo, :mostrar, :aprovar, :editar, :novo ],
         :redirect_to => { :action => :list }

  def list
    @documento_pages, @documentos = paginate :documentos, :per_page => numberOfPages, :order => "titulo"
  end

  def show
    @documento = Documento.find(params[:id])
  end

  def new
    @documento = Documento.new
    @users = User.find_all.collect{ |t| [t.login, t.id] }
    @areas = Area.find_all.collect{ |c| [c.codigo, c.id] }
    @artigos = Artigo.find(:all, :conditions => ['usado = :usado', {:usado => false}], :order => "nome").collect{ |a| [a.nome, a.id] }
    @show = true
  end

  def create
    begin
      @documento = Documento.new(params[:documento])
      unless @documento.artigo_id.nil?
        @artigo = Artigo.find(@documento.artigo_id)
        @artigo.usado = true
        @documento.criado = @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
        @documento.aprovado = false
        if (@documento.save && @artigo.save)
          flash[:message] = 'Documento criado com sucesso!'
          Notifications.deliver_docApproval('adm.tuia@gmail.com', @documento.titulo, @documento.criado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.user.nome)
          redirect_to :action => 'list'
        else
          flash[:warning] = "Cadastramento do documento não efetuado..."
          @users = User.find_all.collect{ |t| [t.login, t.id] }
          @areas = Area.find_all.collect{ |c| [c.codigo, c.id] }
          @artigos = Artigo.find(:all, :conditions => ['usado = :usado', {:usado => false}]).collect{ |a| [a.nome, a.id] }
          @show = true
          render :action => 'new'
        end
      else
        flash[:warning] = "Documento não pode ser criado. Erro: 'Não existe artigo disponível'..."
        redirect_to :action => 'list'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'list'
    end
  end

  def edit
    @documento = Documento.find(params[:id])
    @show = false
    @isresumo = @documento.artigo.isresumo
  end

  def update
    begin
      @documento = Documento.find(params[:id])
      @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @documento.aprovado = false
      if @documento.artigo.isresumo
        @artigo = Artigo.find(@documento.artigo_id)
        @nome = @artigo.nome
        @artigo.attributes = params[:artigo]
        unless @artigo.nome.eql?@nome
          @artigo.isresumo = false
          @artigo.update
        end
      end
      if @documento.update_attributes(params[:documento])
        flash[:message] = 'Documento alterado com sucesso!'
        Notifications.deliver_docApproval('adm.tuia@gmail.com', @documento.titulo, @documento.criado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.user.nome)
        redirect_to :action => 'show', :id => @documento
      else
        flash[:warning] = "Alteração do documento não efetuado..."
        render :action => 'edit'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'show', :id => @documento
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do documento não efetuada. Erro: 'Artigo já existente'..."
      redirect_to :action => 'show', :id => @documento
    end
  end

  def destroy
    @documento = Documento.find(params[:id])
    @artigo = Artigo.find(@documento.artigo_id)
    @artigo.usado = false
    if @artigo.update
      @documento.destroy
      flash[:message] = 'Documento excluído com sucesso!'
    else
      flash[:warning] = 'Exclusão do documento não efetuado...'
    end
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
    @area = params[:area]
  end

  def novo
    @documento = Documento.new
    @user_id = current_user.id
    @area_id = params[:id]
    @area = params[:area]
    @show = true
    @artigos = Artigo.find(:all, :conditions => ['usado = :usado', {:usado => false}], :order => "nome").collect{ |a| [a.nome, a.id] }
  end

  def editar
    @documento = Documento.find(params[:id])
    @area = params[:area]
    @show = false
    @isresumo = @documento.artigo.isresumo
  end

  def updateUsr
    begin
      @documento = Documento.find(params[:id])
      @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
      @documento.aprovado = false
      @area = params[:area]
      if @documento.artigo.isresumo
        @artigo = Artigo.find(@documento.artigo_id)
        @nome = @artigo.nome
        @artigo.attributes = params[:artigo]
        unless @artigo.nome.eql?@nome
          @artigo.isresumo = false
          @artigo.update
        end
      end
      if @documento.update_attributes(params[:documento])
        flash[:message] = 'Documento alterado com sucesso!'
        Notifications.deliver_docApproval('adm.tuia@gmail.com', @documento.titulo, @documento.criado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.user.nome)
        redirect_to :action => 'getDocsArea', :id => @documento.area
      else
        flash[:warning] = "Alteração do documento não efetuada..."
        render :action => 'editar'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getDocsArea', :id => @documento.area
    rescue  ActiveRecord::StatementInvalid
      flash[:warning] = "Alteração do documento não efetuada. Erro: 'Artigo já existente'..."
      redirect_to :action => 'getDocsArea', :id => @documento.area
    end
  end

  def createUsr
    begin
      @documento = Documento.new(params[:documento])
      unless @documento.artigo_id.nil?
        @documento.user_id = params[:user_id]
        @documento.area_id = params[:area_id]
        @documento.criado = @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
        @documento.aprovado = false
        @artigo = Artigo.find(@documento.artigo_id)
        @artigo.usado = true
        if (@documento.save && @artigo.save)
          flash[:message] = 'Documento criado com sucesso!'
          Notifications.deliver_docApproval('adm.tuia@gmail.com', @documento.titulo, @documento.criado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.user.nome)
          redirect_to :action => 'getDocsArea', :id => @documento.area
        else
          flash[:warning] = "Cadastramento do documento não efetuado..."
          @artigos = Artigo.find(:all, :conditions => ['usado = :usado', {:usado => false}]).collect{ |a| [a.nome, a.id] }
          @user_id = current_user.id
          @area_id = params[:area_id]
          @area = params[:area]
          @show = true
          render :action => 'novo'
        end
      else
        flash[:warning] = "Documento não pode ser criado. Erro: 'Não existe artigo disponível'..."
        redirect_to :action => 'list'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getDocsArea', :id => @documento.area
    end
  end

  def createUsrArt
    begin
      @documento = Documento.new(params[:documento])
      @documento.artigo_id = params[:artigo_id]
      unless @documento.artigo_id.nil?
        @artigo = Artigo.find(@documento.artigo_id)
        @artigo.usado = true
        @documento.user_id = current_user.id
        @documento.criado = @documento.alterado = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
        @documento.aprovado = false
        if (@documento.save && @artigo.save)
          flash[:message] = 'Documento criado com sucesso!'
          Notifications.deliver_docApproval('adm.tuia@gmail.com', @documento.titulo, @documento.criado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.alterado.strftime("%d/%m/%Y - %H:%M:%S"), @documento.user.nome)
          redirect_to :action => 'getDocsArea', :id => @documento.area
        else
          flash[:warning] = "Cadastramento do documento não efetuado. Erro: 'Os campos Título e Resenha são obrigatórios'..."
          @artigo_id = params[:artigo_id]
          @artigo_nome = params[:artigo_nome]
          @areas = Area.find_all.collect{ |c| [c.codigo, c.id] }
          redirect_to :back
        end
      else
        flash[:warning] = "Documento não pode ser criado. Erro: 'Não existe artigo disponível'..."
        redirect_to :controller => "artigo", :action => 'listar'
      end
    rescue Timeout::Error
      flash[:warning] = "E-mail de notificação não enviado. Erro: 'Tempo de operação esgotado'..."
      redirect_to :action => 'getDocsArea', :id => @documento.area
    end
  end

  def getDocsArea
    @documento_pages, @documentos = paginate :documentos, :conditions => { :area_id => params[:id], :aprovado => true }, :per_page => numberOfPages, :order => "titulo"
    @area = params[:area]
    @idArea = params[:id]
    render :action => 'listar'
  end

  def getAnexo
    @documento = Documento.find(params[:id])
    send_data(@documento.anexo, :filename => "#{@documento.nome}")
  end
end
