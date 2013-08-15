# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'

Bundler.setup
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BeerJudge'
  app.deployment_target = "6.0"
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down]
  app.identifier = 'com.mohawkapps.BeerJudge'
  app.version = "2"
  app.short_version = "1.0.1"
  app.frameworks += %w(AVFoundation CoreVideo CoreMedia ImageIO QuartzCore)
  app.prerendered_icon = true
  app.info_plist['APP_STORE_ID'] = 666120064
  app.info_plist['CFBundleURLTypes'] = [
    { 'CFBundleURLName' => 'com.mohawkapps.BeerJudge',
      'CFBundleURLSchemes' => ['beerjudge'] }
  ]
  app.info_plist['UIRequiredDeviceCapabilities'] = ['still-camera']

  app.pods do
    pod 'FlurrySDK'
    pod 'Appirater'
    pod 'Harpy'
    pod 'OpenInChrome'
    pod 'CMPopTipView', :podspec => 'vendor/specs/CMPopTip.podspec'
  end

  # Vendor Projects - ARC
  %w(KTOneFingerRotationGestureRecognizer CKImageAdditions).each do |v|
    app.vendor_project("vendor/#{v}", :static, :cflags => '-fobjc-arc')
  end
  # Vendor Projects - non-ARC
  %w(CaptureSessionManager UIColor-Utilities).each do |v|
    app.vendor_project("vendor/#{v}", :static)
  end

  app.files_dependencies 'app/Classes/DetailScreen.rb' => 'app/Classes/SizeableWebScreen.rb'

  app.development do
    app.entitlements['get-task-allow'] = true
    app.codesign_certificate = "iPhone Developer: Mark Rickert (YA2VZGDX4S)"
    app.provisioning_profile = "./provisioning/development.mobileprovision"
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = "iPhone Distribution: Mohawk Apps, LLC (DW9QQZR4ZL)"
    app.provisioning_profile = "./provisioning/release.mobileprovision"
  end

end
