class RoleController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset, :is_admin

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :new ],
         :redirect_to => { :action => :list }

  def list
    @role_pages, @roles = paginate :roles, :per_page => numberOfPages, :order => "nome"
  end

  def new
    @role = Role.new
  end

  def create
    begin
      @role = Role.new(params[:role])
      if @role.save
        flash[:message] = 'Perfil criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do perfil não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do perfil não efetuado. Erro: 'Perfil já existe'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Role.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de perfil não efetuada. Erro: 'Perfil está sendo usado por algum usuário. Remova esta referência antes de excluir o perfil'..."
    else
      flash[:message] = 'Perfil excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
end
