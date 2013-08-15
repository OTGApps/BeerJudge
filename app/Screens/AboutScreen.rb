class AboutScreen < PM::WebScreen

  title "About"

  def content
    "AboutScreen.html"
  end

  def on_load
    set_tab_bar_item icon: "tab_info", title: "About"
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack
  end

  def will_appear
    Flurry.logEvent "AboutView" unless Device.simulator?
  end

  def should_autorotate
    true
  end

  def supported_orientations
    UIInterfaceOrientationMaskPortrait
  end
end
