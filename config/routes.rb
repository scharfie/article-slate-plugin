require 'slate/routing'

ActionController::Routing::Routes.draw do |map|
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