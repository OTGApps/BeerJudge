class SRMScreenStylesheet < ApplicationStylesheet

  def top_view(st)
    st.frame = {
      height: 44,
      width: :full,
      left: 0,
      top: 0,
    }
    st.background_color = color.white
  end

  def top_view_label(st)
    st.frame = st.prev_frame
    st.text = "Touch Below!"
    st.font = UIFont.boldSystemFontOfSize(UIFont.systemFontSize)
    st.text_alignment = :center
    st.background_color = color.clear
  end

  def gradient_view(st)
    st.frame = {
      left: 0,
      top: 44,
      width: :full,
      fb: 49,
    }
    st.background_color = color.red
    st.background_gradient = {
      locations: nil,
      colors: SRM.ui_spectrum
    }
  end

end
