class Employer::ArticlesController < Employer::BaseController
  before_action :load_article, except: [:index, :new, :create]

  def index
    params[:type] ||= "time_show"
    params[:sort] ||= "DESC"
    @articles = Article.select(:id, :title, :description, :time_show)
      .search_form params[:search], params[:type], params[:sort]
    @total = @articles.size if params[:search].present?
    @articles = @articles.page(params[:page]).per Settings.article.page

    if request.xhr?
      render json: {
        html_article: render_to_string(partial: "articles",
          articles: @articles, layout: false),
        pagination_article: render_to_string(partial: "articles/paginate",
          layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def show
  end

  def new
    @article = Article.new
    @article.images.build
  end

  def create
    @article = Article.new article_params
    @article.time_show = Time.zone.now unless @article.time_show?

    if @article.save
      flash[:success] = t ".created"
      redirect_to employer_company_articles_path @company
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes article_params
      if params[:show_time] == "now"
        @article.update_attributes time_show: Time.zone.now
      end
      flash[:success] = t ".update"
      redirect_to employer_company_articles_path @company
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = t ".delete"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to employer_company_articles_path @company
  end

  private

  def article_params
    params.require(:article).permit Article::ATTRIBUTES
  end

  def load_article
    return if @article = Article.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to employer_company_articles_path @company
  end
end
