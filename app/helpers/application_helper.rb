module ApplicationHelper
  def fix_url(url)
    (url.starts_with?('http://') || url.starts_with?('https://')) ? url : "http://#{url}"
  end

  def tell_time_posted(time)
    time_lapse = Time.now - time
    case time_lapse
    when 0..10 then "Just Now"
    when 11..60 then "Seconds Ago"
    when 61..(60*60) then "Minutes Ago"
    when (60*60+1)..(60*60*12) then "Hours Ago"
    else time.strftime("%A, %B %d, %Y %H:%M%P %Z")
    end
  end
end
