class FlavorWheel < MasterScreen

  title "Flavor Wheel"
  tab_bar_item item: "tab_flavor_wheel", title: "Flavor Wheel"

  def will_appear
    @rotation_deg = 0
    @view_loaded ||= begin

      view.backgroundColor = UIColor.whiteColor

      wheel_size = Device.screen.height_for_orientation(:portrait) * 1.2
      @wheel = add UIImageView.alloc.initWithImage(UIImage.imageNamed("flavor_wheel.png")), {
        left: 10,
        top: 10,
        width: wheel_size,
        height: wheel_size,
        content_mode: UIViewContentModeScaleAspectFit,
        userInteractionEnabled: true,
      }

      rotateGesture = KTOneFingerRotationGestureRecognizer.alloc.initWithTarget(self, action:"rotating:")
      @wheel.addGestureRecognizer(rotateGesture)

    end
    Crittercism.leaveBreadcrumb("FlavorWheelView") unless Device.simulator?
  end

  def rotating(recognizer)
    view = recognizer.view
    view.setTransform(CGAffineTransformRotate(view.transform, recognizer.rotation))
  end

  def should_autorotate
    true
  end

  def supported_orientations
    UIInterfaceOrientationMaskPortrait
  end
end
