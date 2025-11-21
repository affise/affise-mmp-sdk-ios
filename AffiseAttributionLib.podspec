#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "AffiseAttributionLib"
  spec.version      = ENV['LIB_VERSION'] || "1.6.58"
  spec.summary      = "Affise Attribution iOS library"
  spec.description  = "Affise SDK is a software you can use to collect app usage statistics, device identifiers, deeplink usage, track install referrer."
  spec.homepage     = "https://github.com/affise/affise-mmp-sdk-ios"
  spec.license      = { :type => "MIT", :file => 'LICENSE' }
  spec.author       = { "Affise" => "support@affise.com" }
  spec.source       = { 
    :git => "https://github.com/affise/affise-mmp-sdk-ios.git", 
    :tag => "#{spec.version}" 
  }

  spec.source_files  = "AffiseAttributionLib/Classes/**/*.{h,m,swift}"
  spec.resources = "AffiseAttributionLib/Assets/*.{js}"
  spec.ios.deployment_target = "12.0"
  spec.swift_version = '5.7'
end
