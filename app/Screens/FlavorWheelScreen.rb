class FlavorWheel < PM::Screen

  title "Flavor Wheel"

  def on_load
    set_tab_bar_item icon: "tab_flavor_wheel", title: "Flavor Wheel"
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack
  end

  def will_appear
    @rotation_deg = 0
    @view_loaded ||= begin

      view.backgroundColor = UIColor.whiteColor

      wheel_size = Device.screen.height_for_orientation(:portrait) * 1.2
      ap wheel_size
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
    Flurry.logEvent "FlavorWheelView" unless Device.simulator?
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
