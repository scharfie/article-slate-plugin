class ArticlesController < ResourcesController
  unloadable
  resources_controller_for :articles, :in => :space
  current_tab 'Articles'
  include PeriodicalsHelper

  # Allow RSS
  skip_filter :load_enclosing_resources, :only => 'feed'

protected
  def publish_resource!
    resource.publish!(resource.published_at)
  end

public
  def feed
    self.resources = @space.articles.published(:limit => 10, :order => 'published_at DESC')

    respond_to do |wants|
      wants.rss
    end
  end

  def index
    @published = resource_service.published.all
    @unpublished = resource_service.unpublished.all(:limit => 10, :order => 'published_at DESC')
  end
 
  # Replace the resource_url so that redirects
  # will go to the page (this way, the article
  # can be visible exactly as it will appear
  # on the blog)
  def resource_url(*args)
    space_page_url @space, 'articles',
      hash_for_periodical_path(resource)
  end

  response_for :destroy do |wants|
    wants.html { redirect_to resources_path }
  end
  
  # Publishes the article
  def publish
    self.resource = find_resource
    publish_resource!
    flash[:notice] = 'Succesfully published article!'
    redirect_to resource_url
  end
  
  # Unpublishes the article
  def unpublish
    self.resource = find_resource
    resource.unpublish!
    flash[:notice] = 'Successfully unpublished article!'
    redirect_to resource_url
  end
end