module ModalModule
  def on_load
    if Device.ipad?
      set_nav_bar_button :right, image: UIImage.imageNamed("tab_about"), action: :open_about
    end
  end

  def open_about
    open_modal AboutScreen.new(nav_bar: true, presentation_style: UIModalPresentationFormSheet)
  end
end
