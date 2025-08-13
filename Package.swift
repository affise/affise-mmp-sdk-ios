// swift-tools-version: 5.6
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
        .library(name: "AffiseModuleLink", targets: ["AffiseModuleLink"]),
        .library(name: "AffiseModulePersistent", targets: ["AffiseModulePersistent"]),
        .library(name: "AffiseModuleStatus", targets: ["AffiseModuleStatus"]),
        .library(name: "AffiseModuleSubscription", targets: ["AffiseModuleSubscription"]),
        .library(name: "AffiseModuleTikTok", targets: ["AffiseModuleTikTok"]),
        .library(name: "AffiseSKAdNetwork", targets: ["AffiseSKAdNetwork", "AffiseInternalWrapperObjC"]),
        .library(name: "AffiseInternal", targets: ["AffiseInternal"]),
    ],
    targets: [
        .target(
            name: "AffiseAttributionLib",
            path: "AffiseAttributionLib",
            sources: [ "Classes" ],
            resources: [
               .process("Assets"),
            ]
        ),
        .target(
            name: "AffiseModuleAdService",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/AdService",
            sources: [ "Classes" ],
            linkerSettings: [
                .linkedFramework("AdServices"),
            ]
        ),
        .target(
            name: "AffiseModuleAdvertising",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Advertising",
            sources: [ "Classes" ]
        ),
        .target(
            name: "AffiseModuleAppsFlyer",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/AppsFlyer",
            sources: [ "Classes" ]
        ),
        .target(
            name: "AffiseModuleLink",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Link",
            sources: [ "Classes" ]
        ),
        .target(
            name: "AffiseModulePersistent",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Persistent",
            sources: [ "Classes" ]
        ),
        .target(
            name: "AffiseModuleStatus",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Status",
            sources: [ "Classes" ]
        ),
        .target(
            name: "AffiseModuleSubscription",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/Subscription",
            sources: [ "Classes" ],
            linkerSettings: [
                .linkedFramework("StoreKit"),
            ]
        ),
        .target(
            name: "AffiseModuleTikTok",
            dependencies: ["AffiseAttributionLib"],
            path: "AffiseModule/TikTok",
            sources: [ "Classes" ]
        ),
        .target(
            name: "AffiseSKAdNetwork",
            dependencies: ["AffiseInternalWrapperObjC"],
            path: "AffiseSKAdNetwork",
            sources: [ "Classes" ]
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
            sources: [ "Classes" ]
        ),
    ]
)
