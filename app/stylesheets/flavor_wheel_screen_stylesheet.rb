class FlavorWheelScreenStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  def wheel(st)
    wheel_size = Device.screen.height_for_orientation(:portrait) * 1.2
    st.frame = {
      left: 10,
      top: 10,
      width: wheel_size,
      height: wheel_size,
    }
    st.image = image.resource("flavor_wheel")
    st.content_mode = :scale_aspect_fit
    st.user_interaction_enabled = true
  end

end
