xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@space.name}"
    xml.description "Recently published articles"
    xml.link page_url(@page)
    
    resources.each do |e|
      xml.item do
        xml.title       e.name
        xml.description e.body_html
        xml.pubDate     e.published_at.to_s(:rfc822)
        xml.link        url = periodical_url(e)
        xml.guid        url
      end
    end
  end
end