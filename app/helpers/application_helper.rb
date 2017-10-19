module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Chris' KB"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
end
