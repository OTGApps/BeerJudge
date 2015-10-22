class SRMAnalyzerScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  def live_preview(st)
    video_ratio = 4.0/3.0
    st.frame = {
      left: 0,
      top: 0,
      width: :full,
      height: device_width * video_ratio
    }
    st.background_color = color.white
  end

  def gradient_view(st)
    gradient_view_size = find(:live_preview).frame.width / 3
    st.frame = {
      fr: 0,
      t: 0,
      fb: 50,
      width: gradient_view_size
    }
    st.background_color = color.white
    st.background_gradient = {
      locations: nil,
      colors: SRM.ui_spectrum
    }
  end

  def captured_image_preview(st)
    gradient_view_size = find(:live_preview).frame.width / 3
    st.frame = {
      fl: 0,
      fb: 50,
      w: gradient_view_size,
      h: gradient_view_size
    }
    st.content_mode = :scale_aspect_fit
    st.background_color = color.white
  end

  def average_color(st)
    gradient_view_size = find(:live_preview).frame.width / 3
    st.frame = {
      left: 0,
      fb: 50,
      width: device_width - gradient_view_size,
      height: gradient_view_size,
    }
    st.background_color = color.white
  end

  def target_area(st)
    st.image = image.resource("srm_analyzer_target")
    image_size = 50
    live_preview = find(:live_preview).frame
    st.frame = {
      left: (live_preview.width / 3) - (image_size / 2),
      top: (live_preview.height / 2) - (image_size),
      width: image_size,
      height: image_size
    }
  end

  def slider(st)
    gradient_view = find(:gradient_view)
    st.frame = {
      left: gradient_view.frame.x,
      top: gradient_view.frame.y,
      width: gradient_view.frame.width,
      height: 2,
    }
    st.background_color = color.red
  end

  def capture_button(st)
    captured_image_preview = find(:captured_image_preview)
    image_size = 75

    st.frame = {
      fr: (captured_image_preview.frame.width / 2) - (image_size / 2) + captured_image_preview.frame.x,
      top: (captured_image_preview.frame.height / 2) - (image_size / 2) + captured_image_preview.frame.y,
      width: image_size,
      height: image_size,
    }

    st.background_image_normal = image.resource("CaptureButton")
    st.background_image_highlighted = image.resource("CaptureButton")
  end

  def color_view_label(st)
    st.frame = find(:average_color).frame
    st.text = "Calculated SRM: --"
    st.font = UIFont.boldSystemFontOfSize(UIFont.systemFontSize)
    st.text_alignment = :center
    st.background_color = color.clear
  end

end
