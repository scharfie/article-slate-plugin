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
  end
end