class ModeloprovaController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset
  before_filter :is_admin, :except => ['showModel']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :show ],
         :redirect_to => { :action => :list }

  def list
    @modeloprova_pages, @modeloprovas = paginate :modeloprovas, :per_page => numberOfPages
  end

  def show
    @modeloprova = Modeloprova.find(params[:id])
  end

  def new
    @modeloprova = Modeloprova.new
  end

  def create
    begin
      @modeloprova = Modeloprova.new(params[:modeloprova])
      unless @modeloprova.nome.nil?
        if @modeloprova.save
          flash[:message] = 'Modelo de Prova criado com sucesso!'
          redirect_to :action => 'list'
        else
          flash[:warning] = "Cadastramento do Modelo de Prova não efetuado..."
          render :action => 'new'
        end
      else
        flash[:warning] = "Cadastramento do Modelo de Prova não efetuado. Erro: 'Campo Modelo é obrigatório'..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do Modelo de Prova não efetuado. Erro: 'Modelo de Prova já existente no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Modeloprova.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de Modelo de Prova não efetuada. Erro: 'Modelo de Prova está sendo usado em alguma prova. Remova esta prova antes de excluir o Modelo de Prova'..."
    else
      flash[:message] = 'Modelo de Prova excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
  
  def showModel
    @modeloprova = Modeloprova.find(params[:id])
    send_data(@modeloprova.modelo, :filename => "#{@modeloprova.nome}")
  end
end
