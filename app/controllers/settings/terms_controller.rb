class Settings::TermsController < SettingsController

  before_filter :find_term, :only => [:show, :edit, :update, :destroy]
  
  def index
    @terms = Term.find(:all, :order => "begin_date DESC")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def new
    @term = Term.new

    respond_to do |format|
      format.html { render :action => :edit }
    end
  end


  def edit
  end


  def create
    @term = Term.new(params[:term])

    respond_to do |format|
      if @term.save
        flash[:notice] = 'Term was successfully created.'
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update

    respond_to do |format|
      if @term.update_attributes(params[:term])
        flash[:notice] = 'Term was successfully updated.'
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @term.destroy

    respond_to do |format|
      format.html { redirect_to(terms_url) }
    end
  end
  
protected
  def find_term
    @term = Term.find(params[:id])
  end
end
