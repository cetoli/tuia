class QuestionarioController < ApplicationController
  layout "tuia"
  include Smerf

  before_filter :login_required, :set_charset
  before_filter :is_admin, :only => ['new', 'deactivate', 'listar', 'activate']

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :deactivate, :create, :activate ],
         :redirect_to => { :action => :list }

  def list
    self.smerf_user_id = current_user.id
    @smerfForm_pages, @smerfForms = paginate :smerfForms, :per_page => numberOfPages, :conditions => ['active = :active', {:active => 1}], :order => "name"
  end

  def listar
    @smerfForm_pages, @smerfForms = paginate :smerfForms, :per_page => numberOfPages, :conditions => ['active = :active', {:active => 0}], :order => "name"
  end

  def create
    self.smerf_user_id = current_user.id
    filename = params[:nome]
    begin
      SmerfFile.file_exists?(filename)
      redirect_to("/smerf_forms/#{filename}")
    rescue RuntimeError => runError
      flash[:warning] = "O arquivo indicado não existe. Erro: '#{runError.message}'..."
      render :action => 'new'
    end
  end

  def deactivate
    @smerfform = SmerfForm.find(params[:id])
    @smerfform.active = 0
    if @smerfform.save
      flash[:message] = 'Questionário desativado com sucesso!'
      redirect_to :action => 'list'
    else
      flash[:warning] = "Questionário não pôde ser desativado..."
      redirect_to :action => 'list'
    end
  end

  def activate
    @smerfform = SmerfForm.find(params[:id])
    @smerfform.active = 1
    if @smerfform.save
      flash[:message] = 'Questionário ativado com sucesso!'
      redirect_to :action => 'listar'
    else
      flash[:warning] = "Questionário não pôde ser ativado..."
      redirect_to :action => 'listar'
    end
  end
end
