# Install slate hooks
Slate::Plugin.install('article') do |plugin|
  plugin.navigation do |tabs|
    tabs.add 'Articles', space_articles_path(Space.active)
  end
  
  plugin.mount 'articles', 
    :name => 'Articles', 
    :template => 'blog.html.erb'
end  