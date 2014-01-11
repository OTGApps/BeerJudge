class SRMScreen < MasterScreen

  title "SRM Spectrum"
  tab_bar_item icon: "tab_srm_spectrum", title: "SRM"

  def on_load
    self.navigationController.navigationBar.translucent = false
    self.automaticallyAdjustsScrollViewInsets = false
    self.edgesForExtendedLayout = UIRectEdgeNone
  end

  def will_appear
    @view_loaded ||= begin
      # view.setBackgroundColor UIColor.redColor
      @top_view_height = 44

      @srm_views ||= []
      height = self.view.frame.size.height - @top_view_height

      @gradient_view = add UIView.new, {
        left: 0,
        top: @top_view_height,
        width: self.view.frame.size.width,
        height: height,
      }
      @gradient_view.setBackgroundColor UIColor.whiteColor

      @gradient = CAGradientLayer.layer
      @gradient.frame = view.bounds
      @gradient.colors = SRM.spectrum

      @gradient_view.layer.insertSublayer(@gradient, atIndex:0)

      @gradient_view.when_panned do |gesture|
        got_touch_point gesture.locationInView(@gradient_view)
      end

      @gradient_view.when_tapped do |gesture|
        got_touch_point gesture.locationInView(@gradient_view)
      end

      # Add a top view that changes color.
      @top_view = add UIView.new, {
        left: 0,
        top: 0,
        width: view.frame.size.width,
        height: @top_view_height,
        background_color: UIColor.whiteColor
      }
      @top_view_label = add UILabel.new, {
        frame: @top_view.frame,
        text: "Touch Below!",
        font: UIFont.boldSystemFontOfSize(UIFont.systemFontSize),
        textAlignment: UITextAlignmentCenter,
        background_color: UIColor.clearColor
      }

    end
    Flurry.logEvent "SRMView" unless Device.simulator?
  end

  def got_touch_point(cgpoint)
    total_height = Device.screen.height_for_orientation(Device.orientation) - 44
    total_steps = SRM.steps.count + 1
    step_height = total_height / total_steps

    srm = (cgpoint.y / step_height).to_i + 1

    return if srm < 1

    if srm.to_s.length == 1
      srm_string = "      #{srm.to_s}     "
    else
      srm_string = "     #{srm.to_s}     "
    end

    @indicators_initialized ||= begin

      #Hide the "touch me" label
      @top_view_label.hidden = true

      @srm_indicator = set_attributes CMPopTipView.alloc.initWithTitle("SRM:", message:""), {
        delegate: nil,
        titleAlignment: UITextAlignmentCenter,
        textAlignment: UITextAlignmentCenter,
        preferredPointDirection: PointDirectionDown,
        userInteractionEnabled: false
      }
      @srm_indicator.disableTapToDismiss = true

      @target_tap_view = add UIView.new
    end

    if srm > total_steps / 2
      text_border_color = UIColor.whiteColor
    else
      text_border_color = UIColor.blackColor
    end

    set_attributes @srm_indicator, {
      message: srm_string,
      backgroundColor: SRM.color(srm),
      textColor: text_border_color,
      titleColor: text_border_color,
      borderColor: text_border_color
    }

    @target_tap_view.frame = CGRectMake(cgpoint.x, cgpoint.y + @top_view_height - 5, 1, 1)

    @srm_indicator.presentPointingAtView(@target_tap_view, inView:view, animated:false)
    @top_view.backgroundColor = SRM.color(srm)
  end

  def should_autorotate
    true
  end

  def supported_orientations
    UIInterfaceOrientationMaskPortrait
  end
end
