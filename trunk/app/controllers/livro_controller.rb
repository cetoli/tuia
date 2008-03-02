class LivroController < ApplicationController
  layout "tuia"

  before_filter :login_required, :set_charset

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :getCapa, :getLivro ],
         :redirect_to => { :action => :list }

  def list
    @livro_pages, @livros = paginate :livros, :per_page => numberOfPages, :order => "titulo"
  end

  def new
    @livro = Livro.new
  end

  def create
    begin
      @livro = Livro.new(params[:livro])
      if @livro.save
        flash[:message] = 'Livro criado com sucesso!'
        redirect_to :action => 'list'
      else
        flash[:warning] = "Cadastramento do livro não efetuado..."
        render :action => 'new'
      end
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Cadastramento do livro não efetuado. Erro: 'Livro já existente no Banco de Dados'..."
      render :action => 'new'
    end
  end

  def destroy
    begin
      Livro.find(params[:id]).destroy
    rescue ActiveRecord::StatementInvalid
      flash[:warning] = "Exclusão de livro não efetuada. Erro: 'Erro no Banco de Dados'..."
    else
      flash[:message] = 'Livro excluído com sucesso!'
    ensure
      redirect_to :action => 'list'
    end
  end
  
  def getLivro
    @livro = Livro.find(params[:id])
    send_data(@livro.conteudo, :filename => "#{@livro.nomeCont}")
  end
  
  def getCapa
    @livro = Livro.find(params[:id])
    send_data(@livro.capa, :filename => "#{@livro.nomeCapa}")
  end
end
