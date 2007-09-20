class UserController < ApplicationController
  layout "tuia"

  before_filter :login_required, :except => ['login', 'signup', 'about']
  before_filter :is_admin, :only => ['list', 'show', 'new', 'edit']
  before_filter :set_charset

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :logout, :aprovar ],
         :redirect_to => { :action => :list }

  def index
    redirect_to :action => "welcome"
  end

  def aprovar
    @user = User.find(params[:id])
    @user.aprovado = true
    if @user.update
      flash[:message] = 'Usu�rio aprovado com sucesso!'
      Notifications.deliver_userAcceptance(@user.email, @user.nome, @user.login)
      redirect_to :action => 'show', :id => @user
    else
      flash[:warning] = "Aprova��o do usu�rio n�o efetuada..."
      render :action => 'show', :id => @user
    end
  end

  def signup
    @user = User.new(params[:user])
    @user.admin = false
    @user.aprovado = false
    if request.post?  
      if @user.save
        flash[:message] = "Cadastramento efetuado com sucesso! Aguarde confirma��o sobre sua aprova��o."
        Notifications.deliver_userApproval('adm.tuia@gmail.com', @user.nome, @user.email)
        redirect_to :action => "about"
      else
        flash[:warning] = "Cadastramento n�o efetuado..."
      end
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:senha])
        flash[:message] = "Login efetuado com sucesso!"
        redirect_to_stored
      else
        flash[:warning] = "Login n�o efetuado..."
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logout efetuado com sucesso!'
    redirect_to :action => 'login'
  end

  def change_password
    @user = session[:user]
    if request.post?
      if @user.update_attributes(:senha => params[:user][:senha], :confirmacao_senha => params[:user][:confirmacao_senha])
        flash[:message] = "Senha alterada!"
      else
        flash[:warning] = "Problemas na altera��o da senha..."
      end
    end
  end

  def list
    @user_pages, @users = paginate :users, :per_page => numberOfPages, :order => "nome"
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.aprovado = true
    if @user.save
      flash[:message] = 'Usu�rio criado com sucesso!'
      redirect_to :action => 'list'
    else
      flash[:warning] = "Problemas na cria��o do usu�rio..."
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:message] = 'Usu�rio alterado com sucesso!'
      redirect_to :action => 'show', :id => @user
    else
      flash[:warning] = "Problemas na altera��o do usu�rio..."
      render :action => 'edit'
    end
  end

  def destroy
    begin
      User.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclus�o de usu�rio n�o efetuada. Erro: 'Usu�rio possui documento(s) aprovado(s) ou pendente(s) de aprova��o. Remova estes documentos antes de excluir o usu�rio'..."
    else
      flash[:message] = 'Usu�rio exclu�do com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
