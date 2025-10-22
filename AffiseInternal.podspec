#
#  Be sure to run `pod spec lint AffiseInternal.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "AffiseInternal"
  spec.version      = ENV['LIB_VERSION'] || "1.6.57"
  spec.summary      = "Affise Internal library"
  spec.description  = "Affise Internal wrapper library for crossplatform"
  spec.homepage     = "https://github.com/affise/affise-mmp-sdk-ios"
  spec.license      = { :type => "MIT", :file => 'LICENSE' }
  spec.author       = { "Affise" => "support@affise.com" }
  spec.source       = { 
    :git => "https://github.com/affise/affise-mmp-sdk-ios.git", 
    :tag => "#{spec.version}" 
  }

  spec.source_files  = "AffiseInternal/Classes/**/*.{swift}"  
  spec.ios.deployment_target = "12.0"
  spec.swift_version = '5.7'
  
  spec.dependency "AffiseAttributionLib", "#{spec.version}"
  spec.dependency "AffiseSKAdNetwork", "#{spec.version}"
end
