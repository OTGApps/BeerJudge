class AppDelegate < ProMotion::Delegate

  tint_color "#581A27".to_color

  def on_load(app, options)
    # 3rd Party integrations
    unless Device.simulator?
      app_id = NSBundle.mainBundle.objectForInfoDictionaryKey('APP_STORE_ID')

      # Flurry
      NSSetUncaughtExceptionHandler("uncaughtExceptionHandler")
      Flurry.startSession("3W88Z2Q6MR87NHGDSMVV")

      # Appirater
      Appirater.setAppId app_id
      Appirater.setDaysUntilPrompt 5
      Appirater.setUsesUntilPrompt 10
      Appirater.setTimeBeforeReminding 5
      Appirater.appLaunched true

      # Harpy
      Harpy.sharedInstance.setAppID app_id
      Harpy.sharedInstance.checkVersion
    end

    # Set initial font size (%)
    App::Persistence['font_size'] = 100 if App::Persistence['font_size'].nil?

    flavor_wheel = FlavorWheel.new nav_bar: true
    off_flavors = OffFlavorsScreen.new nav_bar: true
    srm = SRMScreen.new nav_bar: true
    analyzer = SRMAnalyzer.new nav_bar: true

    about_vc = AboutViewController.alloc.init
    about = UINavigationController.alloc.initWithRootViewController(about_vc)

    vcs = [flavor_wheel, off_flavors, srm]
    vcs << analyzer if Device.camera.rear? || Device.simulator?
    vcs << about unless Device.ipad?

    @nav_stack = open_tab_bar vcs

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
    when "about"
      @nav_stack.selectedIndex = 4
    end

    true
  end

  #Flurry exception handler
  def uncaughtExceptionHandler(exception)
    Flurry.logError("Uncaught", message:"Crash!", exception:exception)
  end

  def applicationWillEnterForeground(application)
    Appirater.appEnteredForeground true unless Device.simulator?
  end

end
