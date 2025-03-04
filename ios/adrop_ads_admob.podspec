#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint adrop_ads_admob.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'adrop_ads_admob'
  s.version          = '0.2.0'
  s.summary          = 'Adrop ads for admob mediation'
  s.description      = 'AdropAds flutter plugin for admob mediation'
  s.homepage         = 'http://openrhapsody.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Open Rhapsody' => 'dev@openrhapsody.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'adrop-ads-mediation-admob', '~> 0.2', '< 1.0'
  s.static_framework = true
  s.platform = :ios, '13.0'


  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
