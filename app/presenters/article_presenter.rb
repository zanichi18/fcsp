class ArticlePresenter
  def initialize company, params
    @params = params
    @params[:type] ||= "time_show"
    @params[:sort] ||= "DESC"
    @articles_all = company.articles
      .select(:id, :title, :description, :time_show)
      .search_form @params[:search], @params[:type], @params[:sort]
  end

  def total
    @total ||= @articles_all.size if @params[:search].present?
  end

  def articles
    @articles ||= @articles_all.page(@params[:page]).per Settings.article.page
  end
end
