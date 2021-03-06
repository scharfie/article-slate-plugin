class ArticlePlugin < Slate::Plugin
  name 'Articles'
  description 'Create blog articles for your site'
  
  navigation do |tabs|
    tabs.add 'Articles', space_articles_path(Space.active)
  end
  
  routes do |map|
    map.with_space do |space|
      space.resources :articles, :member => {
        :publish => :any, :unpublish => :any 
      }
    end
    
    map.public_routes do |public|
      public.with_options(:controller => 'articles', :action => 'feed') do |a|
        a.connect 'articles.rss'
        a.connect '*page_path/articles.rss'
      end  
    end
  end
  
  mount 'articles', :name => 'Articles', :template => 'blog.html.erb'

  # Possible future syntax
  # mount 'articles' do |m|
  #   m.helper 'ArticlesHelper'
  #   m.page.name = 'Articles'
  #   m.page.template = 'blog.html.erb'
  # end
end