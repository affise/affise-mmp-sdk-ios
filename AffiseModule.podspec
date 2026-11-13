#
# Be sure to run `pod lib lint AffiseModule.podspec` to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name         = "AffiseModule"
  s.version      = ENV["LIB_VERSION"] || "1.7.18"
  s.summary      = "Affise Modules"
  s.description  = "Affise module collection"
  s.homepage     = "https://github.com/affise/affise-mmp-sdk-ios"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Affise" => "support@affise.com" }
  s.source       = {
     :git => "https://github.com/affise/affise-mmp-sdk-ios.git", 
     :tag => "#{s.version}", 
     :submodules => true
  }

  s.ios.deployment_target = "12.0"
  s.swift_version = "5.7"
  s.static_framework = true

  s.dependency "AffiseAttributionLib", "#{s.version}"
  
  s.subspec "AdService" do |sub|
    sub.resource_bundles = { "AffiseModuleAdServicePrivacy" => ["AffiseModule/AdService/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/AdService/Classes/**/*.{swift}"
    sub.frameworks  = "AdServices"
  end

  s.subspec "Advertising" do |sub|
    sub.resource_bundles = { "AffiseModuleAdvertisingPrivacy" => ["AffiseModule/Advertising/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Advertising/Classes/**/*.{swift}"
  end
  
  s.subspec "AppsFlyer" do |sub|
    sub.resource_bundles = { "AffiseModuleAppsFlyerPrivacy" => ["AffiseModule/AppsFlyer/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/AppsFlyer/Classes/**/*.{swift}"
  end

  s.subspec "Google" do |sub|
    sub.resource_bundles = { "AffiseModuleGooglePrivacy" => ["AffiseModule/Google/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Google/Classes/**/*.{swift}"
    sub.dependency "GoogleAdsOnDeviceConversion"
  end

  s.subspec "Hardware" do |sub|
    sub.resource_bundles = { "AffiseModuleHardwarePrivacy" => ["AffiseModule/Hardware/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Hardware/Classes/**/*.{swift}"
  end

  s.subspec "Link" do |sub|
    sub.resource_bundles = { "AffiseModuleLinkPrivacy" => ["AffiseModule/Link/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Link/Classes/**/*.{swift}"
  end
  
  s.subspec "Persistent" do |sub|
    sub.resource_bundles = { "AffiseModulePersistentPrivacy" => ["AffiseModule/Persistent/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Persistent/Classes/**/*.{swift}"
  end

  s.subspec "Status" do |sub|
    sub.resource_bundles = { "AffiseModuleStatusPrivacy" => ["AffiseModule/Status/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Status/Classes/**/*.{swift}"
  end

  s.subspec "Subscription" do |sub|
    sub.resource_bundles = { "AffiseModuleSubscriptionPrivacy" => ["AffiseModule/Subscription/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/Subscription/Classes/**/*.{swift}"
    sub.framework  = "StoreKit"
  end
  
  s.subspec "TikTok" do |sub|
    sub.resource_bundles = { "AffiseModuleTikTokPrivacy" => ["AffiseModule/TikTok/PrivacyInfo.xcprivacy"] }
    sub.source_files = "AffiseModule/TikTok/Classes/**/*.{swift}"
  end
end
