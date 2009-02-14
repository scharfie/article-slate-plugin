require_dependency 'article'

module ArticlesHelper
  # Renders blog
  def article_engine
    # legacy support for old blog plugin
    @blog = @space
    
    if periodicals_by_day?
      '- Show articles for day'
      debug @space.articles.find_by_date(params[:year], params[:month], params[:day])
    elsif periodicals_by_month?
      '- Show articles for month'
      show_articles_by_month
    elsif periodicals_by_year?
      '- Show articles for year'
      debug @space.articles.find_by_date(params[:year])
    elsif periodicals_by_slug?
      show_article_by_slug
    else
      show_recent_articles
    end
  end
  
  alias_method :blog_engine, :article_engine
  
  def show_articles_by_month
    @articles = @space.articles.published.on_date(params[:year], params[:month])
    @archive  = Article::Archive.new(Date.new(params[:year].to_i, params[:month].to_i, 1))
    partial :articles_by_month, :object => @articles
  end
  
  def show_article_by_slug
    scope = editor? && slate? ? :draft : :published
    @article = @space.articles.send(scope).find_by_permalink(params[:slug])
    partial :article, :object => @article
  end
  
  def show_recent_articles
    scope = editor? && slate? ? :draft : :published
    order = editor? && slate? ? 'updated_at DESC' : 'published_at DESC'
    @articles = @space.articles.send(scope).all(:limit => 5, :order => order)
    partial :article, :collection => @articles
  end
  
  # Returns a link to article (using the article name for text)
  def article_link(article, options={})
    link_to options.delete(:text) || article.name, periodical_url(article, options)
  end
  
  # Returns nicely formatted date for the article's
  # published date
  def article_date(article, format=':nday, :nmonth :day:ordinal :year &mdash; :hour12::minute :meridian')
    (article.published_at || article.updated_at).eztime(format)
  end
  
  def article_tools(article)
    render :partial => 'builder/article_tools', :locals => { :article => article }
  end
  
  def archive_date(format=':nmonth :year')
    @archive.eztime(format)
  end
  
  def article_feed_url
    options = { :controller => 'articles', :action => 'feed', :only_path => false }
    options.merge!(:page_path => params[:page_path]) unless params[:page_path].blank?
    url_for(options)
  end
end