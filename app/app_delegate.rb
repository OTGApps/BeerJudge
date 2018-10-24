class AppDelegate < ProMotion::Delegate

  attr_accessor :about
  tint_color "#581A27".to_color

  def on_load(app, options)
    # 3rd Party integrations
    unless Device.simulator?
      app_id = App.info_plist['APP_STORE_ID']

      # Crittercism Debugging on devices
      crittercism_app_id = "562939d78d4d8c0a00d07f0f"
      Crittercism.enableWithAppID(crittercism_app_id)
    end

    # Set initial font size (%)
    App::Persistence['font_size'] = 100 if App::Persistence['font_size'].nil?

    flavor_wheel = FlavorWheel.new nav_bar: true
    off_flavors = OffFlavorsScreen.new nav_bar: true
    srm = SRMScreen.new nav_bar: true
    analyzer = SRMAnalyzer.new nav_bar: true

    about_screen = AboutScreen.new nav_bar:true
    # self.about.modalPresentationStyle = UIModalPresentationFormSheet

    vcs = [flavor_wheel, off_flavors, srm]
    vcs << analyzer if Device.camera.rear? || Device.simulator?
    vcs << about_screen unless Device.ipad?

    @nav_stack = open_tab_bar vcs
    @tab_bar.delegate = self
  end

  def tabBar(tabBar, didSelectItem:item)
    puts item.title
  end

  def application(application, openURL:url, sourceApplication:sourceApplication, annotation:annotation)
    NSLog("Launched with URL: %@", url.absoluteString)
    suffix = url.absoluteString.split("//").last

    case suffix
    when "flavor_wheel"
      @nav_stack.selectedIndex = 0
    when "off_flavors"
      @nav_stack.selectedIndex = 1
    when "srm_spectrum"
      @nav_stack.selectedIndex = 2
    when "srm_analyzer"
      @nav_stack.selectedIndex = 3
    end

    true
  end

end
