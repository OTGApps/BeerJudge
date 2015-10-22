class DetailScreen < SizeableWebScreen
  attr_accessor :description, :search_string

  def on_appear
    super
    Crittercism.leaveBreadcrumb("OffFlavorViewed - #{self.title}")
  end

  def content
<<-CONTENT
#{css}
#{js}
#{formatted_description}
#{search_js}
CONTENT
  end

  def formatted_description
    f_desc = ""
    self.description.split("\n").each do |d|
      f_desc << "<p>" << d << "</p>"
    end
    f_desc
  end

  def css
    "<style>" << File.read(File.join(App.resources_path, "style.css")) << "</style>"
  end

  def js
    return "" if self.search_string.nil?
    "<script>" << File.read(File.join(App.resources_path, "highlighter.js")) << "</script>"
  end

  def search_js
    return "" if self.search_string.nil?
    "<script>" << "$('p').highlight('" << self.search_string << "')" << "</script>"
  end

end
