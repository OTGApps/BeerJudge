class AppDelegate < ProMotion::Delegate

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

    flavor_wheel = FlavorWheel.new nav_bar: true
    srm = SRM.new nav_bar: true
    about = AboutScreen.new nav_bar: true

    if Device.camera.rear? || Device.simulator?
      analyzer = SRMAnalyzer.new nav_bar: true
      @nav_stack = open_tab_bar flavor_wheel, srm, analyzer, about
    else
      @nav_stack = open_tab_bar flavor_wheel, srm, about
    end
  end

  def application(application, openURL:url, sourceApplication:sourceApplication, annotation:annotation)
    NSLog("Launched with URL: %@", url.absoluteString)
    suffix = url.absoluteString.split("//").last

    case suffix
    when "flavor_wheel"
      @nav_stack.selectedIndex = 0
    when "srm_spectrum"
      @nav_stack.selectedIndex = 1
    when "srm_analyzer"
      @nav_stack.selectedIndex = 2
    when "about"
      @nav_stack.selectedIndex = 3
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
