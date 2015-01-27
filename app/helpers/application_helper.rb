module ApplicationHelper
  def fix_url(url)
    (url.starts_with?('http://') || url.starts_with?('https://')) ? url : "http://#{url}"
  end
end
