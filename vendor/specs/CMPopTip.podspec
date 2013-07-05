Pod::Spec.new do |s|
  s.name     = 'CMPopTipView'
  s.version  = '1.2.0'
  s.license  = 'MIT'
  s.summary  = 'Custom UIView for iOS that pops up an animated "bubble" pointing at a button or other view. Useful for popup tips.'
  s.homepage = 'https://github.com/chrismiles/CMPopTipView'
  s.author   = { 'Chris Miles' => 'http://chrismiles.info/' }
  s.source   = { :git => 'https://github.com/chrismiles/CMPopTipView.git', :commit => '3d9b3a2b035cbcd8f8540e452f2eab5c8d4c00ba' }
  s.platform = :ios
  s.source_files = 'CMPopTipView/*.{h,m}'
  s.framework = 'UIKit'
end
