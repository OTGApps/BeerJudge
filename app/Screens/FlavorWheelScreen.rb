class FlavorWheel < PM::Screen
  include ModalModule

  title "Flavor Wheel"
  tab_bar_item item: "tab_flavor_wheel", title: "Flavor Wheel"
  stylesheet FlavorWheelScreenStylesheet

  def on_load
    wheel = append!(UIImageView, :wheel)
    rotateGesture = KTOneFingerRotationGestureRecognizer.alloc.initWithTarget(self, action:"rotating:")
    wheel.addGestureRecognizer(rotateGesture)
  end

  def will_appear
    @rotation_deg = 0
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
