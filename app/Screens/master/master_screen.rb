class MasterScreen < PM::Screen

  def on_load
    if Device.ipad?
      set_nav_bar_right_button UIImage.imageNamed("tab_about"), action: :open_about
    end
  end

  def open_about
    self.presentModalViewController(App.delegate.about, animated:true)
  end

end
