# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'

Bundler.setup
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Beer Judge'
  app.identifier = 'com.mohawkapps.BeerJudge'

  app.short_version = "1.2.0"
  app.version = (`git rev-list HEAD --count`.strip.to_i).to_s

  app.deployment_target = "7.1"
  app.frameworks += %w(AVFoundation CoreVideo CoreMedia ImageIO QuartzCore)

  app.icons = Dir.glob("resources/Icon*.png").map{|icon| icon.split("/").last}
  app.prerendered_icon = true

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down]

  app.info_plist['APP_STORE_ID'] = 666120064
  app.info_plist['CFBundleURLTypes'] = [
    { 'CFBundleURLName' => 'com.mohawkapps.BeerJudge',
      'CFBundleURLSchemes' => ['beerjudge'] }
  ]
  app.info_plist['UIRequiredDeviceCapabilities'] = ['still-camera']

  app.pods do
    pod 'FlurrySDK'
    pod 'Appirater'
    pod 'CMPopTipView'
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
    app.provisioning_profile = "./provisioning/WildcardDevelopment.mobileprovision"
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = "iPhone Distribution: Mohawk Apps, LLC (DW9QQZR4ZL)"
    app.provisioning_profile = "./provisioning/release.mobileprovision"
  end

end
