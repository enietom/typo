class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index; redirect_to :action => 'new' ; end
  def edit; new_or_edit; end
  def new; new_or_edit; end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  private

  def save_category
    logger.debug(params[:category].inspect)
    if (params[:category][:id].empty?)
      logger.debug("1")
      @category = Category.new
    else
      logger.debug("2")
      @category = Category.find(params[:category][:id])
    end
    @category.attributes = params[:category]
    logger.debug("3")
    if @category.save!
      logger.debug("4")
      flash[:notice] = _('Category was successfully saved.')
    else
    logger.debug("5")
      flash[:error] = _('Category could not be saved.')
    end
    
    respond_to do |format|
      format.html { redirect_to :action => 'new' }
      format.js do 
        @article = Article.new
        @article.categories << @category
        return render(:partial => 'admin/content/categories')
      end
    end
  end

  def new_or_edit
    if request.post?
      save_category
    else
      @categories = Category.find(:all)
      logger.debug("params[:id]: #{params[:id]}")
      @category = Category.find(params[:id]) if params[:id]
      @category = Category.new unless @category
      
      respond_to do |format|
        format.html { render 'new' }
        format.js { 
          @category = Category.new
        }
      end
    end
  end

end
