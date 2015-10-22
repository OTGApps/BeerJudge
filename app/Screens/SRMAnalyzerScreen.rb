class SRMAnalyzer < PM::Screen
  include ModalModule

  title "SRM Analyzer"
  tab_bar_item item: "tab_eyedropper", title: "Analyzer"
  stylesheet SRMAnalyzerScreenStylesheet

  attr_accessor :live_preview, :still_image_output, :captured_image_preview

  def on_load
    super
    self.navigationController.navigationBar.translucent = false
    self.automaticallyAdjustsScrollViewInsets = false
    self.edgesForExtendedLayout = UIRectEdgeNone

    #Live Preview video screen setup
    self.live_preview = append!(UIView, :live_preview)
    self.still_image_output = AVCaptureStillImageOutput.new

    # Camera View Setup
    @session = AVCaptureSession.alloc.init
    @session.sessionPreset = AVCaptureSessionPresetLow

    captureVideoPreviewLayer = set_attributes AVCaptureVideoPreviewLayer.alloc.initWithSession(@session), {
      frame: self.live_preview.frame,
      background_color: UIColor.blueColor
    }

    self.live_preview.layer.addSublayer(captureVideoPreviewLayer)
    device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

    # Try and start the AVCaptureSession
    error_ptr = Pointer.new(:object)
    input = AVCaptureDeviceInput.deviceInputWithDevice(device, error:error_ptr)
    error = error_ptr #De-reference the pointer.
    if !input
      # Handle the error appropriately.
      NSLog("ERROR: trying to open camera: %@", error)
    else
      @session.addInput(input)
      self.still_image_output.setOutputSettings({AVVideoCodecKey: AVVideoCodecJPEG})

      @session.addOutput(still_image_output)
      @session.startRunning
    end

    #Create the gradient view.
    gradient_view_size = self.live_preview.frame.size.width / 3
    @gradient_view = append!(UIView, :gradient_view)

    # Placeholder for captured image.
    self.captured_image_preview = append!(UIImageView, :captured_image_preview)

    # Placeholder for average image color.
    @average_color = append!(UIView, :average_color)

    # Add the target image over top of the live camera view.
    @target_area = append!(UIImageView, :target_area)

    # Create the red Slider bar on the the gradient view.
    @slider = append!(UIView, :slider)
    @slider_constraints = {
      origin: @gradient_view.frame.origin.y,
      height: @gradient_view.frame.size.height
    }

    # Create the button
    @capture_button = append!(UIButton, :capture_button).on(:tap){ captureNow }

    @color_view_label = append!(UILabel, :color_view_label)

    Crittercism.leaveBreadcrumb("AnalyzerView") unless Device.simulator?

  end

  def will_appear
    if Device.simulator?
      App.alert("Unfortunately, this feature ONLY works on real devices.")
    end
  end

  def will_disappear
    if !@session.nil? && @session.respond_to?("running") && @session.running == true
      @session.stopRunning
    end
  end

  def captureNow
    videoConnection = nil
    still_image_output.connections.each do |connection|
      connection.inputPorts.each do |port|
        if port.mediaType == AVMediaTypeVideo
          videoConnection = connection
          break
        end
      end
      break if videoConnection
    end

    NSLog("about to request a capture from: %@", still_image_output)
    still_image_output.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler:lambda do |imageSampleBuffer, error|
      exif_attachments = CMGetAttachment( imageSampleBuffer, KCGImagePropertyExifDictionary, nil) || {}

      imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
      image = UIImage.alloc.initWithData(imageData)

      cropped = image.image_resized(self.live_preview.frame.size).crop(@target_area.frame)
      self.captured_image_preview.image = cropped

      avg_color = cropped.averageColorAtPixel(CGPointMake(cropped.size.width, cropped.size.height), radius:(cropped.size.width / 2.0))
      @average_color.setBackgroundColor avg_color

      my_calculated_srm = SRM.closest_srm_to_color(avg_color)
      move_slider_to_srm(my_calculated_srm[0].to_i)

      if my_calculated_srm[0].to_i > SRM.steps.count / 2
        text_color = UIColor.whiteColor
      else
        text_color = UIColor.blackColor
      end

      match = {srm: my_calculated_srm[0], closeness: my_calculated_srm[1]}
      if my_calculated_srm[1] < 50
        set_attributes @color_view_label, {
          number_of_lines: 1,
          text: "Calculated SRM: #{my_calculated_srm[0]}",
          textColor: text_color
        }
        match[:good_match] = true
      else
        # Warn them that a good match could not be found
        set_attributes @color_view_label, {
          number_of_lines: 2,
          text: "Calculated SRM: #{my_calculated_srm[0]}\n(Not a good match)",
          textColor: text_color
        }
        match[:good_match] = false
      end

      Crittercism.leaveBreadcrumb("AnalyzerImageCaptured") unless Device.simulator?

     end)
  end

  def scanButtonPressed
    @scanningLabel.setHidden(false)
    self.performSelector("hideLabel:", withObject:@scanningLabel, afterDelay:2)
  end

  def hideLabel(label)
    label.setHidden(true)
  end

  def move_slider_to_srm(srm)
    UIView.animateWithDuration(0.75,
      animations:lambda {
        @slider.frame = CGRectMake(
          @slider.frame.origin.x,
          @slider_constraints[:origin] + (@slider_constraints[:height] / (SRM.steps.count + 1) * srm),
          @slider.frame.size.width,
          @slider.frame.size.height
        )
      })
  end

  def should_autorotate
    true
  end

  def supported_orientations
    UIInterfaceOrientationMaskPortrait
  end

end
