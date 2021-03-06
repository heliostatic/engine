xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc "http://#{request.host}#{":#{request.port}" if request.port != 80}"
    xml.priority 1.0
  end

  @pages.each do |page|
    if not page.index_or_not_found?
      if page.templatized?

        page.content_type.contents.visible.each do |c|
          xml.url do
            xml.loc page_main_url(page, { :content => c, :host => true })
            xml.lastmod c.updated_at.to_date.to_s('%Y-%m-%d')
            xml.priority 0.9
          end
        end
      else
        xml.url do
          xml.loc page_main_url(page, { :host => true })
          xml.lastmod page.updated_at.to_date.to_s('%Y-%m-%d')
          xml.priority 0.9
        end
      end
    end
  end

end
