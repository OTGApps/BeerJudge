# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  define_icon_defaults!(app)

  app.name = 'BeerJudge'
  app.identifier = 'com.mohawkapps.BeerJudge'

  app.short_version = "1.4.0"
  app.version = (`git rev-list HEAD --count`.strip.to_i).to_s

  app.deployment_target = "9.3"
  app.frameworks += %w(AVFoundation CoreVideo CoreMedia ImageIO QuartzCore)

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :portrait_upside_down]

  app.info_plist['APP_STORE_ID'] = 666120064
  app.info_plist['CFBundleURLTypes'] = [
    { 'CFBundleURLName' => app.identifier,
      'CFBundleURLSchemes' => ['beerjudge'] }
  ]
  app.info_plist['UIRequiredDeviceCapabilities'] = ['still-camera']
  app.info_plist['UIRequiresFullScreen'] = true

  app.pods do
    pod 'CrittercismSDK'
    pod 'CMPopTipView'
    pod 'CKImageAdditions', :git => 'https://github.com/cmkilger/CKImageAdditions.git'
  end

  # app.info_plist['UIRequiresFullScreen'] = true
  # app.info_plist['ITSAppUsesNonExemptEncryption'] = false

  # Vendor Projects - ARC
  %w(KTOneFingerRotationGestureRecognizer).each do |v|
    app.vendor_project("vendor/#{v}", :static, :cflags => '-fobjc-arc')
  end
  # Vendor Projects - non-ARC
  %w(UIColor-Utilities).each do |v|
    app.vendor_project("vendor/#{v}", :static)
  end

  app.files_dependencies 'app/Classes/DetailScreen.rb' => 'app/Classes/SizeableWebScreen.rb'

  MotionProvisioning.output_path = '../provisioning'
  app.development do
    app.entitlements['get-task-allow'] = true

    app.codesign_certificate = MotionProvisioning.certificate(
      type: :development,
      platform: :ios)

    app.provisioning_profile = MotionProvisioning.profile(
      bundle_identifier: app.identifier,
      app_name: app.name,
      platform: :ios,
      type: :development)
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.entitlements['beta-reports-active'] = true

    app.codesign_certificate = MotionProvisioning.certificate(
      type: :distribution,
      platform: :ios)

    app.provisioning_profile = MotionProvisioning.profile(
      bundle_identifier: app.identifier,
      app_name: app.name,
      platform: :ios,
      type: :distribution)
  end
end

def define_icon_defaults!(app)
  app.info_plist['CFBundleIcons'] = {
    'CFBundlePrimaryIcon' => {
      'CFBundleIconName' => 'AppIcon',
      'CFBundleIconFiles' => ['AppIcon60x60']
    }
  }

  app.info_plist['CFBundleIcons~ipad'] = {
    'CFBundlePrimaryIcon' => {
      'CFBundleIconName' => 'AppIcon',
      'CFBundleIconFiles' => ['AppIcon60x60', 'AppIcon76x76']
    }
  }
end
