class ArticlePlugin < Slate::Plugin
  name 'Articles'
  description 'Create blog articles for your site'
  
  navigation do |tabs|
    tabs.add 'Articles', space_articles_path(Space.active)
  end
  
  mount 'articles', :name => 'Articles', :template => 'blog.html.erb'
end