class AboutScreen < PM::WebScreen

  title "About"

  def content
    "AboutScreen.html"
  end

  def on_load
    set_tab_bar_item icon: "tab_info", title: "About"
    self.navigationController.navigationBar.barStyle = self.navigationController.toolbar.barStyle = UIBarStyleBlack
  end

  def will_appear
    @view_loaded ||= begin
      self.navigationController.setToolbarHidden(false)
      self.toolbarItems = [flexible_space, made_in_label, made_in_image, flexible_space]
    end

    Flurry.logEvent "AboutView" unless Device.simulator?
  end

  def made_in_label
    label = set_attributes UILabel.alloc.initWithFrame(CGRectZero), {
      frame: CGRectMake(0.0 , 11.0, view.frame.size.width, 21.0),
      font: UIFont.fontWithName("Helvetica-Bold", size:16),
      background_color: UIColor.clearColor,
      text: "Made in North Carolina",
      text_alignment: UITextAlignmentCenter,
      text_color: UIColor.whiteColor
    }
    label.sizeToFit
    UIBarButtonItem.alloc.initWithCustomView(label)
  end

  def made_in_image
    image = UIImage.imageNamed("nc.png")
    image_view = set_attributes UIView.new, {
      frame: CGRectMake(0, 0, image.size.width, image.size.height),
    }
    image_view.setBackgroundColor( UIColor.colorWithPatternImage(image) )
    UIBarButtonItem.alloc.initWithCustomView(image_view)
  end

  def flexible_space
    UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target:nil, action:nil)
  end

  def should_autorotate
    true
  end

  def supported_orientations
    UIInterfaceOrientationMaskPortrait
  end
end
