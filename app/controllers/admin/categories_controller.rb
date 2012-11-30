class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index; redirect_to :action => 'new' ; end
  def edit; new_or_edit;  end

  def new 
    respond_to do |format|
      format.html { new_or_edit }
      format.js { 
        @category = Category.new
      }
    end
  end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  def save_category
    if (params[:category][:id].empty?)
      @category = Category.new
    else
      @category = Category.find(params[:category][:id])
    end
    @category.attributes = params[:category]
    if @category.save!
      flash[:notice] = _('Category was successfully saved.')
    else
      flash[:error] = _('Category could not be saved.')
    end
    
    respond_to do |format|
      format.html { redirect_to :action => 'new' }
      format.js do 
        @category.save
        @article = Article.new
        @article.categories << @category
        return render(:partial => 'admin/content/categories')
      end
    end
  end

  private

  def new_or_edit
    @categories = Category.find(:all)
    if request.post?
      save_category
      return
    end
    @category = Category.find(params[:id]) if params[:id]
    render 'new'
  end

end
