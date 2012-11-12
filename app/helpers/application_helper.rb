module ApplicationHelper
  #smart_truncate taken from http://stackoverflow.com/questions/1293573/rails-smart-text-truncation
  def smart_truncate(text, char_limit)
    text = text.squish
    size = 0
    text.mb_chars.split().reject do |token|
      size+=token.size()
      size>char_limit
    end.join(" ")
  end
  
  def get_location_else(default)
    if session.present?
      session[:last_location]
    else
      default
    end
  end
end