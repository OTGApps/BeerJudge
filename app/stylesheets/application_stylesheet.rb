class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # An example of setting standard fonts and colors
    font_family = 'Helvetica Neue'
    font.add_named :large,    font_family, 36
    font.add_named :medium,   font_family, 24
    font.add_named :small,    font_family, 18

    color.add_named :tint, '236EB7'
  end

end
