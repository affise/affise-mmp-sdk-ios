// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Affise",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "AffiseAttributionLib", targets: ["AffiseAttributionLib"]),
        .library(name: "AffiseModuleAdService", targets: ["AffiseModuleAdService"]),
        .library(name: "AffiseModuleAdvertising", targets: ["AffiseModuleAdvertising"]),
        .library(name: "AffiseModuleAppsFlyer", targets: ["AffiseModuleAppsFlyer"]),
        .library(name: "AffiseModuleGoogle", targets: ["AffiseModuleGoogle"]),
        .library(name: "AffiseModuleHardware", targets: ["AffiseModuleHardware"]),
        .library(name: "AffiseModuleLink", targets: ["AffiseModuleLink"]),
        .library(name: "AffiseModulePersistent", targets: ["AffiseModulePersistent"]),
        .library(name: "AffiseModuleStatus", targets: ["AffiseModuleStatus"]),
        .library(name: "AffiseModuleSubscription", targets: ["AffiseModuleSubscription"]),
        .library(name: "AffiseModuleTikTok", targets: ["AffiseModuleTikTok"]),
        .library(name: "AffiseSKAdNetwork", targets: ["AffiseSKAdNetwork", "AffiseInternalWrapperObjC"]),
        .library(name: "AffiseInternal", targets: ["AffiseInternal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/google-ads-on-device-conversion-ios-sdk.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "AffiseAttributionLib",
            path: "AffiseAttributionLib",
            sources: [ "Classes" ],
            resources: [
               .process("Assets"),
               .process("PrivacyInfo.xcprivacy"),
            ]
        ),
        .target(
            name: "AffiseModuleAdService",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/AdService",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")],
            linkerSettings: [
                .linkedFramework("AdServices"),
            ]
        ),
        .target(
            name: "AffiseModuleAdvertising",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Advertising",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModuleAppsFlyer",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/AppsFlyer",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModuleGoogle",
            dependencies: [
                "AffiseAttributionLib",
                .product(name: "GoogleAdsOnDeviceConversion", package: "google-ads-on-device-conversion-ios-sdk"),
            ],
            path: "AffiseModule/Google",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModuleHardware",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Hardware",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModuleLink",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Link",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModulePersistent",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Persistent",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModuleStatus",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Status",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseModuleSubscription",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Subscription",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")],
            linkerSettings: [
                .linkedFramework("StoreKit"),
            ]
        ),
        .target(
            name: "AffiseModuleTikTok",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/TikTok",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseSKAdNetwork",
            dependencies: ["AffiseInternalWrapperObjC"],
            path: "AffiseSKAdNetwork",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "AffiseInternalWrapperObjC",
            path: "AffiseSKAdNetwork",
            sources: [ "ObjC" ],
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("StoreKit"),
            ]
        ),
        .target(
            name: "AffiseInternal",
            dependencies: [
                "AffiseAttributionLib",
                "AffiseSKAdNetwork",
            ],
            path: "AffiseInternal",
            sources: [ "Classes" ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
    ]
)
