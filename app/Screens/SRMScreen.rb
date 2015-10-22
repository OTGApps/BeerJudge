class SRMScreen < PM::Screen
  include ModalModule

  title "SRM Spectrum"
  tab_bar_item item: "tab_srm_spectrum", title: "SRM"
  stylesheet SRMScreenStylesheet

  def on_load
    super
    self.navigationController.navigationBar.translucent = false
    self.automaticallyAdjustsScrollViewInsets = false
    self.edgesForExtendedLayout = UIRectEdgeNone

    append(UIView, :gradient_view)
    append(UIView, :top_view)
    append(UILabel, :top_view_label)
  end

  def will_appear
    find(:gradient_view).on(:pan) do |view, event|
      got_touch_point(event.location)
    end.on(:tap) do |view, event|
      got_touch_point(event.location)
    end

    Crittercism.leaveBreadcrumb("SRMView") unless Device.simulator?
  end

  def will_disappear
    find(:gradient_view).off
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
      find(:top_view_label).hide

      @srm_indicator = CMPopTipView.alloc.initWithTitle("SRM:", message:"").tap do |ptv|
        ptv.delegate = nil
        ptv.titleAlignment = UITextAlignmentCenter
        ptv.textAlignment = UITextAlignmentCenter
        ptv.preferredPointDirection = PointDirectionDown
        ptv.userInteractionEnabled = false
        ptv.disableTapToDismiss = true
      end

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

    @target_tap_view.frame = CGRectMake(cgpoint.x, cgpoint.y + 44 - 5, 1, 1)

    @srm_indicator.presentPointingAtView(@target_tap_view, inView:view, animated:false)
    find(:top_view).style{|st| st.background_color = SRM.color(srm) }
  end

  def should_autorotate
    true
  end

  def supported_orientations
    UIInterfaceOrientationMaskPortrait
  end
end
