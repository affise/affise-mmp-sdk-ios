# Affise Attribution iOS Library

[Change Log](CHANGELOG.md)

| Pod                         | Version                   |
| --------------------------- |:-------------------------:|
| `AffiseAttributionLib`      | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/a/9/3/AffiseAttributionLib) |
| `AffiseSKAdNetwork`         | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/3/6/f/AffiseSKAdNetwork)    |
| `AffiseModule/AdService`  | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/Advertising`  | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/AppsFlyer`    | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/Link`         | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/Persistent`   | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/Status`       | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/Subscription` | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |
| `AffiseModule/TikTok`       | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/)        |

- [Affise Attribution iOS Library](#affise-attribution-ios-library)
- [Description](#description)
  - [Quick start](#quick-start)
    - [SDK compatibility](#sdk-compatibility)
  - [Integration](#integration)
    - [Integrate as Cocoapods](#integrate-as-cocoapods)
    - [Integrate as Swift Package Manager](#integrate-as-swift-package-manager)
    - [Initialize](#initialize)
      - [Initialization callbacks](#initialization-callbacks)
      - [Domain](#domain)
    - [Modules](#modules)
      - [Installed active modules](#installed-active-modules)
      - [Manual exclude modules](#manual-exclude-modules)
      - [Module AdService](#module-adservice)
      - [Module Advertising](#module-advertising)
      - [Module AppsFlyer](#module-appsflyer)
      - [Module Link](#module-link)
      - [Module Persistent](#module-persistent)
      - [Module Status](#module-status)
      - [Module Subscription](#module-subscription)
      - [Module TikTok](#module-tiktok)
    - [Requirements](#requirements)
  - [StoreKit Ad Network](#storekit-ad-network)
- [Features](#features)
  - [ProviderType identifiers collection](#providertype-identifiers-collection)
    - [Attribution](#attribution)
    - [AdService](#adservice)
    - [Advertising](#advertising)
  - [Event send control](#event-send-control)
  - [Events tracking](#events-tracking)
  - [Custom events tracking](#custom-events-tracking)
  - [Predefined event parameters](#predefined-event-parameters)
    - [PredefinedString](#predefinedstring)
    - [PredefinedLong](#predefinedlong)
    - [PredefinedFloat](#predefinedfloat)
    - [PredefinedObject](#predefinedobject)
    - [PredefinedListObject](#predefinedlistobject)
    - [PredefinedListString](#predefinedliststring)
  - [Events buffering](#events-buffering)
  - [Push token tracking](#push-token-tracking)
    - [APNs](#apns)
    - [Firebase](#firebase)
  - [Reinstall Uninstall tracking](#reinstall-uninstall-tracking)
  - [Links](#links)
    - [Deeplinks](#deeplinks)
    - [AppLinks](#applinks)
    - [Get deferred deeplink](#get-deferred-deeplink)
    - [Get deferred deeplink value](#get-deferred-deeplink-value)
  - [Get random user Id](#get-random-user-id)
  - [Get random device Id](#get-random-device-id)
  - [Get providers](#get-providers)
  - [Is first run](#is-first-run)
  - [Get referrer](#get-referrer)
  - [Get referrer parameter](#get-referrer-parameter)
  - [Referrer keys](#referrer-keys)
  - [Get module state](#get-module-state)
  - [WebView tracking](#webview-tracking)
    - [Initialize WebView](#initialize-webview)
    - [Events tracking JS](#events-tracking-js)
    - [Predefined event parameters JS](#predefined-event-parameters-js)
    - [Custom events JS](#custom-events-js)
  - [SDK to SDK integrations](#sdk-to-sdk-integrations)
    - [AdMob](#admob)
    - [AppLovin MAX](#applovin-max)
    - [Helium by Chartboost](#helium-by-chartboost)
    - [ironSource](#ironsource)
  - [Custom](#custom)
    - [ConversionId](#conversionid)
- [Debug](#debug)
  - [Validate credentials](#validate-credentials)
  - [Version](#version)
- [Troubleshoots](#troubleshoots)
  
# Description

Affise SDK is a software you can use to collect app usage statistics, device identifiers, deeplink usage, track install
referrer.

## Quick start

### SDK compatibility

- `Xcode` `14.2+`  
- `iOS`   `12+`

## Integration

### Integrate as Cocoapods

To add the SDK using Cocoapods, specify the version you want to use in your Podfile:

```ruby
affise_version = '1.6.56'
# Affise SDK library
pod 'AffiseAttributionLib', affise_version
# Affise modules
pod 'AffiseModule/AdService', affise_version
pod 'AffiseModule/Advertising', affise_version
pod 'AffiseModule/Link', affise_version
pod 'AffiseModule/Status', affise_version
pod 'AffiseModule/Subscription', affise_version
pod 'AffiseModule/TikTok', affise_version
```

Get source directly from GitHub

```ruby
affise_version = '1.6.56'
# Affise SDK library
pod 'AffiseAttributionLib', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
# Affise modules
pod 'AffiseModule/AdService', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
pod 'AffiseModule/Advertising', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
pod 'AffiseModule/Link', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
pod 'AffiseModule/Status', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
pod 'AffiseModule/Subscription', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
pod 'AffiseModule/TikTok', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => affise_version
```

### Integrate as Swift Package Manager

To add the SDK using SPM:

1. Open XCode project, navigate to `File / Add Packages`.

2. In the `Add New Package` window enter `https://github.com/affise/affise-mmp-sdk-ios` in `search` field.

3. Click on the `Add Package` button.

4. In `Choose Package Products` window select required packages and click `Add Package`, and it will be added to your iOS project and linked automatically.

### Initialize

After library is added as dependency sync project with gradle files and initialize.

For `swift` use:

> Demo app [AppDelegate.swift](example/app/app/AppDelegate.swift)

```swift
import AffiseAttributionLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Affise
            .settings(
                affiseAppId: "Your appId", //Change to your app id
                secretKey: "Your secretKey" //Change to your appToken
            )
            .start(app: application, launchOptions: launchOptions) // Start Affise SDK

        return true
    }
}
```

For `objective-c` use:

> Demo app [AppDelegate.m](example/app-obj-c/app-obj-c/AppDelegate.m)

```objective-c
#import "AppDelegate.h"
#import <AffiseAttributionLib/AffiseAttributionLib-Swift.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    AffiseSettings *affise = [Affise settingsWithAffiseAppId:@"Your appId" //Change to your app id
                                                   secretKey:@"Your secretKey" //Change to your appToken
    ];
    [affise setProduction:false]; //To enable debug methods set Production to false
    [affise startWithApp:application launchOptions:launchOptions]; // Start Affise SDK

    return YES;
}
@end
```

#### Initialization callbacks

Check Affise library initialization

```swift
Affise
    .settings(
        affiseAppId: "Your appId",
        secretKey: "Your secretKey" 
    )
    .setOnInitSuccess {
        // Called if library initialization succeeded
        debugPrint("Affise: init success")
    }
    .setOnInitError { error in
        // Called if library initialization failed
        debugPrint("Affise: init error \(error)")
    }
    .start(app: application, launchOptions: launchOptions)
```

#### Domain

Set SDK server doamin:

```swift
Affise
    .settings(
        affiseAppId: "Your appId",
        secretKey: "Your secretKey"
    )
    .setDomain("https://YourCustomDomain") // Set custom domain
    .start(app: application, launchOptions: launchOptions)
```

### Modules

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> How to install modules read in [Integration section](#integration)
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

| Module         | Version                                                                              |
| -------------- |:------------------------------------------------------------------------------------:|
| `AdService`    | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `Advertising`  | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `AppsFlyer`    | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `Link`         | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `Persistent`   | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `Status`       | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `Subscription` | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |
| `TikTok`       | [`1.6.56`](https://github.com/CocoaPods/Specs/tree/master/Specs/0/3/d/AffiseModule/) |

#### Installed active modules

Get list of installed modules:

```swift
Affise.Module.getModulesInstalled()
```

#### Manual exclude modules

To manually stop modules from starting use `Affise.settings.setDisableModules`:

```swift
Affise
    .settings(
        affiseAppId: "Your appId",
        secretKey: "Your secretKey"
    )
    .setDisableModules([ 
        // Exclude modules from start
        .Advertising,
        .Subscription,
    ])
    .start(app: application, launchOptions: launchOptions) // Start Affise SDK
```

#### Module AdService

`iOS 14.3+`

Sends `attributionToken` from `AdServices` framework `AAAttribution.attributionToken()` to Affise server

#### Module Advertising

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> Advertising Module starting **Manually**
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

```swift
Affise.Module.Advertising.startModule()
```

This module required to Use [`IDFA`](https://developer.apple.com/documentation/adsupport/asidentifiermanager/advertisingidentifier) (Identifier for advertisers)

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> Module Advertising requires `NSUserTrackingUsageDescription` key in `info.plist`
>
> Application **will crash** if key not present
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

Open `info.plist` and add key `NSUserTrackingUsageDescription` with string value. For more information [read requirements](#requirements)

#### Module AppsFlyer

Send AppsFlyer event data to Affise 

[AppsFlyer In-App Events Docs](https://dev.appsflyer.com/hc/docs/in-app-events-ios#example-send-add-to-wishlist-event)

```swift
//AppsFlyer event data
let eventValues: [String: Any] = [
    AFEventParamPrice: 1234.56,
    AFEventParamContentId : "1234567",
]
// Send AppsFlyer event
AppsFlyerLib.shared().logEvent(
    name: AFEventAddToWishlist, 
    values: eventValues
)
// Send AppsFlyer data to Affise
Affise.Module.AppsFlyer.logEvent(AFEventAddToWishlist, withValues: eventValues)
```

Is Module present:

```swift
Affise.Module.AppsFlyer.hasModule()
```

#### Module Link

Return last url in chan of redirection

🟥Support MAX 10 redirections🟥

```swift
Affise.Module.Link.resolve("SITE_WITH_REDIRECTION") { redirectUrl in
    // handle redirect url
}
```

Is Module present:

```swift
Affise.Module.Link.hasModule()
```

#### Module Persistent

> [!NOTE]
>
> Module requires user phone to be authenticated by Apple ID
>
> It uses Apple `Security` framework to store protected information in user account

Persist `device id` value for [Get random device Id](#get-random-device-id) on application reinstall

#### Module Status

```swift
Affise.Module.getStatus(AffiseModules.STATUS) { response in 
    // handle status response
};
```

#### Module Subscription

Get products by ids:

```swift
let ids = ["exampple.product.id_1", "exampple.product.id_2"]

Affise.Module.Subscription.fetchProducts(ids) { result in
    switch result {
    case .failure(let error):
        print("\(error)")
    case .success(let result):
        let products: [AffiseProduct]  = result.products
        let invalidIds: [String] = result.invalidIds
    }
}
```

Purchase product:

```swift
// Specify product type for correct affise event
Affise.Module.Subscription.purchase(product, .CONSUMABLE) { result in
    switch result {
    case .failure(let error):
        print("\(error)")
    case .success(let purchasedInfo):
        let info: AffisePurchasedInfo = purchasedInfo
    }
}
```

Is Module present:

```swift
Affise.Module.Subscription.hasModule()
```

#### Module TikTok

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> Module TikTok requires [TikTok Business iOS SDK](https://github.com/tiktok/tiktok-business-ios-sdk) `1.5.0+`
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

Send TikTok event data to Affise [TikTok Docs](https://business-api.tiktok.com/gateway/docs/index?identify_key=c0138ffadd90a955c1f0670a56fe348d1d40680b3c89461e09f78ed26785164b&language=ENGLISH&doc_id=1739585432134657#item-link-3.2.2%20Content%20parameters%20for%20standard%20events)


```swift
let event: TikTokContentsEvent = TikTokAddToCartEvent()
event.setContentId("ABC")
event.setCurrency(TTCurrency.USD)
event.setDescription("Description of the product")
event.setContentType("Type of the product")
event.setValue("4.99")

let eventContent = TikTokContentParams()
eventContent.price = 4.99
eventContent.quantity = 1
eventContent.brand = "Brand of the product"
eventContent.contentName = "Name of the product"
event.setContents([eventContent]) // You can set several content parameters in an array

// Send TikTok event
TikTokBusiness.trackTTEvent(event)

// Send TikTok event data to Affise
Affise.Module.TikTok.sendEvent(event.eventName, properties: event.properties, eventId: event.eventId)
```

Is Module present:

```swift
Affise.Module.TikTok.hasModule()
```

### Requirements

Affise Advertising module uses `AppTrackingTransparency` framework to get `advertisingIdentifier`
For working functionality your app needs to declare [`NSUserTrackingUsageDescription` permission](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription):

Open XCode project `info.plist` and add key `NSUserTrackingUsageDescription` with string value

```xml
<plist version="1.0">
<dict>
    ...
	<key>NSUserTrackingUsageDescription</key>
	<string>Youre permission text</string>
</dict>
```

## StoreKit Ad Network

To add the SDK using Cocoapods, specify the version you want to use in your Podfile:

```ruby
# Wrapper for StoreKit Ad Network 
pod 'AffiseSKAdNetwork', '1.6.56'
```

Get source directly from GitHub

```ruby
# Wrapper for StoreKit Ad Network 
pod 'AffiseSKAdNetwork', :git => 'https://github.com/affise/affise-mmp-sdk-ios.git', :tag => '1.6.56'
```

For `swift` use:

> Demo app [AppDelegate.swift](example/app/app/AppDelegate.swift)

> [!NOTE]
>
> 🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦
> 
> For ios prior `16.1` first call
> 
> 🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦

```swift
import AffiseSKAdNetwork

AffiseSKAd.register { error in
    // Handle error
}
```

For `objective-c` use:

> Demo app [AppDelegate.m](example/app-obj-c/app-obj-c/AppDelegate.m)

```objective-c
#import <AffiseSKAdNetwork/AffiseSKAdNetwork-Swift.h>

[AffiseSKAd registerWithCompletionHandler:^(NSString * error) {
    // Handle error
}];
```

Updates the fine and coarse conversion values, and calls a completion handler if the update fails.

> [!NOTE]
>
> 🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦
> 
> Second argument `coarseValue` is available in iOS `16.1+`
>
> 🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦🟦

```swift
AffiseSKAd.updatePostbackConversionValue(fineValue: 1, coarseValue: CoarseConversionValue.medium) { error in
    // Handle error
}
```

For `objective-c` use:

```objective-c
#import <AffiseSKAdNetwork/AffiseSKAdNetwork-Swift.h>

[AffiseSKAd updatePostbackWithFineValue:1
                            coarseValue:[CoarseConversionValue medium]
                        completionHandler:^(NSString * error) {
    // Handle error
}];
```

Configure your app to send postback copies to Affise:

Add key `NSAdvertisingAttributionReportEndpoint` to `Info.plist`
Set key value to `https://affise-skadnetwork.com/`

Example: [`example/ios/Runner/Info.plist`](example/ios/Runner/Info.plist)

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
      <key>NSAdvertisingAttributionReportEndpoint</key>
      <string>https://affise-skadnetwork.com/</string>
    </dict>
</array>
```

# Features

## ProviderType identifiers collection

To match users with events and data library is sending, these `ProviderType` identifiers are collected:

### Attribution

- `AFFISE_APP_ID`
- `AFFISE_PKG_APP_NAME`
- `AFF_APP_NAME_DASHBOARD`
- `APP_VERSION`
- `APP_VERSION_RAW`
- `STORE`
- `TRACKER_TOKEN`
- `TRACKER_NAME`
- `FIRST_TRACKER_TOKEN`
- `FIRST_TRACKER_NAME`
- `LAST_TRACKER_TOKEN`
- `LAST_TRACKER_NAME`
- `OUTDATED_TRACKER_TOKEN`
- `INSTALLED_TIME`
- `FIRST_OPEN_TIME`
- `INSTALLED_HOUR`
- `FIRST_OPEN_HOUR`
- `INSTALL_FIRST_EVENT`
- `INSTALL_BEGIN_TIME`
- `INSTALL_FINISH_TIME`
- `REFERRAL_TIME`
- `CREATED_TIME`
- `CREATED_TIME_MILLI`
- `CREATED_TIME_HOUR`
- `UNINSTALL_TIME`
- `REINSTALL_TIME`
- `LAST_SESSION_TIME`
- `CONNECTION_TYPE`
- `CPU_TYPE`
- `HARDWARE_NAME`
- `NETWORK_TYPE`
- `DEVICE_MANUFACTURER`
- `PROXY_IP_ADDRESS`
- `DEEPLINK_CLICK`
- `DEVICE_ATLAS_ID`
- `AFFISE_DEVICE_ID`
- `AFFISE_ALT_DEVICE_ID`
- `ANDROID_ID`
- `ANDROID_ID_MD5`
- `MAC_SHA1`
- `MAC_MD5`
- `GAID_ADID`
- `GAID_ADID_MD5`
- `OAID`
- `OAID_MD5`
- `ALTSTR_ADID`
- `FIREOS_ADID`
- `COLOROS_ADID`
- `REFTOKEN`
- `REFTOKENS`
- `REFERRER`
- `USER_AGENT`
- `MCCODE`
- `MNCODE`
- `ISP`
- `REGION`
- `COUNTRY`
- `LANGUAGE`
- `DEVICE_NAME`
- `DEVICE_TYPE`
- `OS_NAME`
- `PLATFORM`
- `SDK_PLATFORM`
- `API_LEVEL_OS`
- `AFFISE_SDK_VERSION`
- `OS_VERSION`
- `RANDOM_USER_ID`
- `AFFISE_SDK_POS`
- `TIMEZONE_DEV`
- `AFFISE_EVENT_TOKEN`
- `LAST_TIME_SESSION`
- `TIME_SESSION`
- `AFFISE_SESSION_COUNT`
- `LIFETIME_SESSION_COUNT`
- `AFFISE_DEEPLINK`
- `AFFISE_PART_PARAM_NAME`
- `AFFISE_PART_PARAM_NAME_TOKEN`
- `AFFISE_EVENT_NAME`
- `AFFISE_APP_TOKEN`
- `LABEL`
- `AFFISE_SDK_SECRET_ID`
- `UUID`
- `AFFISE_APP_OPENED`
- `PUSHTOKEN`
- `PUSHTOKEN_SERVICE`
- `IS_EMULATOR`

### AdService

- `AD_SERVICE_ATTRIBUTION`

### Advertising

- `ADID`

## Event send control

There are two ways to send events

1. Cache event to later scheduled send in batch

```swift
AddToCartEvent()
    .send()
```

2. Send event right now

```swift
AddToCartEvent()
    .sendNow({
        // handle event send success
    }) { errorResponse in
        // handle event send failed
        // 🟥Warning🟥: event is NOT cached for later send
    }
```

## Events tracking

For example, we want to track what items usually user adds to shopping cart. To send event first create it with
following code

```swift
class Presenter {
    func onUserAddsItemsToCart(items: String) {
        let items = [
            ("items", "cookies, potato, milk")
        ]

        AddToCartEvent("groceries")
            .addPredefinedParameter(PredefinedString.DESCRIPTION, string: "best before 2029")
            .addPredefinedParameter(PredefinedObject.CONTENT, object: items)
            .send() // Send event
    }
}
```

For `objective-c` use:

```objective-c
- (void)onUserAddsItemsToCart:(NSString *)itemsToCart {
    NSArray *items = @[
        @{"items", itemsToCart}
    ];

    Event *event = [[AddToCartEvent alloc] init:@"groceries"];
    [event addPredefinedParameter:PredefinedStringADREV_AD_TYPE value:@"best before 2029"];
    [event addPredefinedParameter:PredefinedObjectCONTENT object:items];
    // Send event
    [event send];
}
```

With above example you can implement other events:

- `AchieveLevel`
- `AddPaymentInfo`
- `AddToCart`
- `AddToWishlist`
- `AdRevenue`
- `ClickAdv`
- `CompleteRegistration`
- `CompleteStream`
- `CompleteTrial`
- `CompleteTutorial`
- `Contact`
- `ContentItemsView`
- `CustomizeProduct`
- `DeepLinked`
- `Donate`
- `FindLocation`
- `InitiateCheckout`
- `InitiatePurchase`
- `InitiateStream`
- `Invite`
- `LastAttributedTouch`
- `Lead`
- `ListView`
- `Login`
- `OpenedFromPushNotification`
- `Order`
- `OrderItemAdded`
- `OrderItemRemove`
- `OrderCancel`
- `OrderReturnRequest`
- `OrderReturnRequestCancel`
- `Purchase`
- `Rate`
- `ReEngage`
- `Reserve`
- `Sales`
- `Schedule`
- `Search`
- `Share`
- `SpendCredits`
- `StartRegistration`
- `StartTrial`
- `StartTutorial`
- `SubmitApplication`
- `Subscribe`
- `TravelBooking`
- `UnlockAchievement`
- `Unsubscribe`
- `Update`
- `ViewAdv`
- `ViewCart`
- `ViewContent`
- `ViewItem`
- `ViewItems`
- `InitialSubscription`
- `InitialTrial`
- `InitialOffer`
- `ConvertedTrial`
- `ConvertedOffer`
- `TrialInRetry`
- `OfferInRetry`
- `SubscriptionInRetry`
- `RenewedSubscription`
- `FailedSubscriptionFromRetry`
- `FailedOfferFromRetry`
- `FailedTrialFromRetry`
- `FailedSubscription`
- `FailedOfferise`
- `FailedTrial`
- `ReactivatedSubscription`
- `RenewedSubscriptionFromRetry`
- `ConvertedOfferFromRetry`
- `ConvertedTrialFromRetry`
- `Unsubscription`

## Custom events tracking

Use any of custom events if default doesn't fit your scenario:

- `CustomId01`
- `CustomId02`
- `CustomId03`
- `CustomId04`
- `CustomId05`
- `CustomId06`
- `CustomId07`
- `CustomId08`
- `CustomId09`
- `CustomId10`

If above event functionality still limits your usecase, you can use `UserCustomEvent`

```swift
UserCustomEvent(eventName: "MyCustomEvent")
    .addPredefinedParameter(PredefinedString.DESCRIPTION, string: "best before 2029")
    .addPredefinedParameter(PredefinedObject.CONTENT, object: [
        ("collection", "Greatest Hits")
    ])
    .send() // Send event
```

## Predefined event parameters

To enrich your event with another dimension, you can use predefined parameters for most common cases.
Add it to any event:

```swift
class Presenter {
    func onUserAddsItemsToCart(items: String) {
        let items = [
            ("items", "cookies, potato, milk")
        ]

        AddToCartEvent("groceries")
            .addPredefinedParameter(PredefinedString.DESCRIPTION, string: "best before 2029")
            .addPredefinedParameter(PredefinedObject.CONTENT, object: items)
            .send() // Send event  
    }
}
```

For `objective-c` use:

```objective-c
- (void)onUserAddsItemsToCart:(NSString *)itemsToCart {
    NSArray *items = @[
        @{"items", itemsToCart}
    ];

    Event *event = [[AddToCartEvent alloc] init:@"groceries"];
    [event addPredefinedParameter:PredefinedStringADREV_AD_TYPE value:@"best before 2029"];
    [event addPredefinedParameter:PredefinedObjectCONTENT object:items];
    // Send event
    [event send];
}
```

In examples above `PredefinedParameters.DESCRIPTION` and `PredefinedObject.CONTENT` is used, but many others is available:

| PredefinedParameter                           | Type             |
|-----------------------------------------------|------------------|
| [PredefinedString](#predefinedstring)         | String           |
| [PredefinedLong](#predefinedlong)             | Int64            |
| [PredefinedFloat](#predefinedfloat)           | Float            |
| [PredefinedObject](#predefinedobject)         | [(String, Any)]  |
| [PredefinedListObject](#predefinedlistobject) | [[(String, Any)]]|
| [PredefinedListString](#predefinedliststring) | [String]         |

### PredefinedString

- `ACHIEVEMENT_ID`
- `ADREV_AD_TYPE`
- `BRAND`
- `BRICK`
- `CATALOGUE_ID`
- `CHANNEL_TYPE`
- `CITY`
- `CLASS`
- `CONTENT_ID`
- `CONTENT_NAME`
- `CONTENT_TYPE`
- `CONVERSION_ID`
- `COUNTRY`
- `COUPON_CODE`
- `CURRENCY`
- `CUSTOMER_SEGMENT`
- `CUSTOMER_TYPE`
- `CUSTOMER_USER_ID`
- `DEEP_LINK`
- `DESCRIPTION`
- `DESTINATION_A`
- `DESTINATION_B`
- `DESTINATION_LIST`
- `NEW_VERSION`
- `OLD_VERSION`
- `ORDER_ID`
- `PARAM_01`
- `PARAM_02`
- `PARAM_03`
- `PARAM_04`
- `PARAM_05`
- `PARAM_06`
- `PARAM_07`
- `PARAM_08`
- `PARAM_09`
- `PARAM_10`
- `PAYMENT_INFO_AVAILABLE`
- `PREFERRED_NEIGHBORHOODS`
- `PRODUCT_ID`
- `PRODUCT_NAME`
- `PURCHASE_CURRENCY`
- `RECEIPT_ID`
- `REGION`
- `REGISTRATION_METHOD`
- `REVIEW_TEXT`
- `SEARCH_STRING`
- `SEGMENT`
- `STATUS`
- `SUBSCRIPTION_ID`
- `SUCCESS`
- `SUGGESTED_DESTINATIONS`
- `SUGGESTED_HOTELS`
- `TUTORIAL_ID`
- `UTM_CAMPAIGN`
- `UTM_MEDIUM`
- `UTM_SOURCE`
- `VALIDATED`
- `VERTICAL`
- `VIRTUAL_CURRENCY_NAME`
- `VOUCHER_CODE`

### PredefinedLong

- `AMOUNT`
- `DATE_A`
- `DATE_B`
- `DEPARTING_ARRIVAL_DATE`
- `DEPARTING_DEPARTURE_DATE`
- `HOTEL_SCORE`
- `LEVEL`
- `MAX_RATING_VALUE`
- `NUM_ADULTS`
- `NUM_CHILDREN`
- `NUM_INFANTS`
- `PREFERRED_NUM_STOPS`
- `PREFERRED_STAR_RATINGS`
- `QUANTITY`
- `RATING_VALUE`
- `RETURNING_ARRIVAL_DATE`
- `RETURNING_DEPARTURE_DATE`
- `SCORE`
- `TRAVEL_START`
- `TRAVEL_END`
- `USER_SCORE`
- `EVENT_START`
- `EVENT_END`

### PredefinedFloat

- `PREFERRED_PRICE_RANGE`
- `PRICE`
- `REVENUE`
- `LAT`
- `LONG`

### PredefinedObject

- `CONTENT`

### PredefinedListObject

- `CONTENT_LIST`

### PredefinedListString

- `CONTENT_IDS`

## Events buffering

Affise library will send any pending events with first opportunity,
but if there is no network connection or device is disabled, events are kept locally for 7 days before deletion.

## Push token tracking

To let affise track push token you need to receive it from your push service provider, and pass to Affise library.

### APNs

Using Apple Push Notification service [Docs](https://developer.apple.com/documentation/usernotifications/registering-your-app-with-apns)

First step enable push notifications capability

Then register your app and retrieve your app's device token

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // ...
    UIApplication.shared.registerForRemoteNotifications()
    return true
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let pushToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    Affise.addPushToken(pushToken, .APPLE)
}
```

### Firebase

Using Firebase [Docs](https://firebase.google.com/docs/cloud-messaging/ios/client)

First add firebase integration to your app 

After you have done with firebase inegration, add to your cloud messaging service `onNewToken` method `Affise.addPushToken(token, service)`

```swift
func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
  print("Firebase registration token: \(String(describing: fcmToken))")

  // New token generated
  Affise.addPushToken(fcmToken, .FIREBASE)
}
```

## Reinstall Uninstall tracking

Affise automaticly track reinstall events by using silent-push technology, to make this feature work, pass push token when it is recreated by user and on you application starts up

See example [Push token tracking](#push-token-tracking)

## Links

### Deeplinks

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> Deeplinks support only **CUSTOM** scheme **NOT** `http` or `https`
>
> For `http` or `https` read how to setup [AppLinks](#applinks)
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

To integrate deeplink support you need:

- Follow how to set up deeplinks in the [official documentation](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app).

- Register deeplink callback right after `Affise.settings(..).start(..)`

```swift
Affise.settings(affiseAppId:affiseAppId, secretKey:secretKey).start(app:app, launchOptions: launchOptions)
Affise.registerDeeplinkCallback { url in
    // full uri "scheme://host/path?parameters"   
    let deeplink = value.deeplink

    // separated for convenience 
    let scheme = value.scheme
    let host = value.host
    let path = value.path
    let queryParametersMap = value.parameters

    if queryParametersMap["<your_uri_key>"].contains("<your_uri_key_value>") == true {
        // handle value
    }
}
```

- Add deeplink handler to [`AppDelegate.swift`](example/app/app/AppDelegate.swift)

```swift
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
) -> Bool {
    Affise.handleDeeplink(url)
    return true
}
```

Add key `CFBundleURLTypes` to `Info.plist`

Example: [`example/app/app/Info.plist`](example/app/app/Info.plist)

Example: `YOUR_SCHEME://YOUR_DOMAIN` (`myapp://mydomain.com`)

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>YOUR_DOMAIN</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_SCHEME</string>
        </array>
    </dict>
</array>
```

Test DeepLink via terminal command:

```terminal
xcrun simctl openurl booted "YOUR_SCHEME://YOUR_DOMAIN/somepath?param=1&list=some&list=other&list=1"
```

### AppLinks

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> You must owne website domain.
>
> And has ability to add file `https://yoursite/.well-known/apple-app-site-association`
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

To integrate applink support you need:

- Follow how to set up applink in the [official documentation](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app).

- Associate your app with your website. [Supporting associated domains](https://developer.apple.com/documentation/xcode/supporting-associated-domains)

- [Configuring an associated domain](https://developer.apple.com/documentation/xcode/configuring-an-associated-domain/)

- Register deeplink callback right after `Affise.settings(..).start(..)`

```swift
Affise.settings(affiseAppId:affiseAppId, secretKey:secretKey).start(app:app, launchOptions: launchOptions)
Affise.registerDeeplinkCallback { url in
    // full uri "scheme://host/path?parameters"   
    let deeplink = value.deeplink

    // separated for convenience 
    let scheme = value.scheme
    let host = value.host
    let path = value.path
    let queryParametersMap = value.parameters

    if queryParametersMap["<your_uri_key>"].contains("<your_uri_key_value>")  == true {
        // handle value
    }
}
```

- Add deeplink handler to `AppDelegate.swift`

```swift
func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
) -> Bool {
    Affise.handleUserActivity(userActivity)
    return true
}
```

Add key `com.apple.developer.associated-domains` to `Info.plist`

Example: `https://YOUR_DOMAIN` (`https://mydomain.com`)

```xml
<key>com.apple.developer.associated-domains</key>
<array>
	<string>applinks:YOUR_DOMAIN</string>
</array>
```

Test DeepLink via terminal command:

```terminal
xcrun simctl openurl booted "https://YOUR_DOMAIN/somepath?param=1&list=some&list=other&list=1"
```

### Get deferred deeplink

> [!NOTE]
>
> Requires [Affise Status Module](#modules)

Use the next public method of SDK to deferred deeplink from server

```swift
Affise.getDeferredDeeplink { deferredDeeplink in
  // handle deferred deeplink
}
```

### Get deferred deeplink value

> [!NOTE]
>
> Requires [Affise Status Module](#modules)

Use the next public method of SDK to deferred deeplink value from server

```swift
Affise.getDeferredDeeplinkValue(ReferrerKey.CLICK_ID) { deferredDeeplinkValue in
  // handle deferred deeplink value
}
```

## Get random user Id

```swift
Affise.getRandomUserId()
```

## Get random device Id

> [!NOTE]
>
> Use [Module Persistent](#module-persistent) to make `device id` more persistent on application reinstall

```swift
Affise.getRandomDeviceId()
```

## Get providers

Returns providers map with [ProviderType](#providertype-identifiers-collection) as key

```swift
let providers: [ProviderType: Any?] = Affise.getProviders()
let key = ProviderType.AFFISE_APP_TOKEN
let value = providers[key]
```

## Is first run

```swift
Affise.isFirstRun()
```

## Get referrer

- Add referrer handler to `AppDelegate.swift`

```swift
func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
) -> Bool {
    Affise.handleUserActivity(userActivity)
    return true
}
```

Use the next public method of SDK

```swift
Affise.getReferrerUrl { referrer in
  // handle referrer
}
```

## Get referrer parameter

- Add referrer handler to `AppDelegate.swift`

```swift
func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
) -> Bool {
    Affise.handleUserActivity(userActivity)
    return true
}
```

Use the next public method of SDK to get referrer parameter by

```swift
Affise.getReferrerUrlValue(ReferrerKey.CLICK_ID) { value in
  // handle referrer value
}
```

## Referrer keys

In examples above `ReferrerKey.CLICK_ID` is used, but many others is available:

- `AD_ID`
- `CAMPAIGN_ID`
- `CLICK_ID`
- `AFFISE_AD`
- `AFFISE_AD_ID`
- `AFFISE_AD_TYPE`
- `AFFISE_ADSET`
- `AFFISE_ADSET_ID`
- `AFFISE_AFFC_ID`
- `AFFISE_CHANNEL`
- `AFFISE_CLICK_LOOK_BACK`
- `AFFISE_COST_CURRENCY`
- `AFFISE_COST_MODEL`
- `AFFISE_COST_VALUE`
- `AFFISE_DEEPLINK`
- `AFFISE_KEYWORDS`
- `AFFISE_MEDIA_TYPE`
- `AFFISE_MODEL`
- `AFFISE_OS`
- `AFFISE_PARTNER`
- `AFFISE_REF`
- `AFFISE_SITE_ID`
- `AFFISE_SUB_SITE_ID`
- `AFFISE_SUB_1`
- `AFFISE_SUB_2`
- `AFFISE_SUB_3`
- `AFFISE_SUB_4`
- `AFFISE_SUB_5`
- `AFFC`
- `PID`
- `SUB_1`
- `SUB_2`
- `SUB_3`
- `SUB_4`
- `SUB_5`

## Get module state

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> Required [Module Status](#module-status)
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

Get state of the module:

```swift
Affise.Module.getStatus(AffiseModules.STATUS) { response in 
    // handle status response
};
```

## WebView tracking

### Initialize WebView

To integrate the library into the JavaScript environment, we added a bridge between JavaScript and the native SDK. Now you can send events and use the functionality of the native library directly from Webview.
Here are step by step instructions:

```swift
// retreive WebView from view hierarhy
@IBOutlet weak var webView: WKWebView!

// make sure javascript is enabled
override func viewDidLoad() {
    super.viewDidLoad()

    webView.configuration.preferences.javaScriptEnabled = true
}

// initialize WebView with Affise native library
Affise.registerWebView(webView)

```

Other Javascript enviroment features is described below.

### Events tracking JS

> Demo app [example/app/app/index.html](example/app/app/index.html)

After WebView is initialized you send events from JavaScript enviroment

```javascript
let data = { card: 4138, type: 'phone' };

new AddPaymentInfoEvent({
  userData: 'taxi',
})
    .addPredefinedParameter(PredefinedString.PURCHASE_CURRENCY, 'USD')
    .addPredefinedParameter(PredefinedFloat.PRICE, 2.19)
    .addPredefinedParameter(PredefinedObject.CONTENT, data);
    .send() // Send event
```

Just like with native SDK, javascript enviroment also provides default events that can be passed from WebView:

- `AchieveLevelEvent`
- `AddPaymentInfoEvent`
- `AddToCartEvent`
- `AddToWishlistEvent`
- `AdRevenueEvent`
- `ClickAdvEvent`
- `CompleteRegistrationEvent`
- `CompleteStreamEvent`
- `CompleteTrialEvent`
- `CompleteTutorialEvent`
- `ContactEvent`
- `ContentItemsViewEvent`
- `CustomId01Event`
- `CustomId02Event`
- `CustomId03Event`
- `CustomId04Event`
- `CustomId05Event`
- `CustomId06Event`
- `CustomId07Event`
- `CustomId08Event`
- `CustomId09Event`
- `CustomId10Event`
- `CustomizeProductEvent`
- `DeepLinkedEvent`
- `DonateEvent`
- `FindLocationEvent`
- `InitiateCheckoutEvent`
- `InitiatePurchaseEvent`
- `InitiateStreamEvent`
- `InviteEvent`
- `LastAttributedTouchEvent`
- `LeadEvent`
- `ListViewEvent`
- `LoginEvent`
- `OpenedFromPushNotificationEvent`
- `OrderEvent`
- `OrderItemAddedEvent`
- `OrderItemRemoveEvent`
- `OrderCancelEvent`
- `OrderReturnRequestEvent`
- `OrderReturnRequestCancelEvent`
- `PurchaseEvent`
- `RateEvent`
- `ReEngageEvent`
- `ReserveEvent`
- `SalesEvent`
- `ScheduleEvent`
- `SearchEvent`
- `ShareEvent`
- `SpendCreditsEvent`
- `StartRegistrationEvent`
- `StartTrialEvent`
- `StartTutorialEvent`
- `SubmitApplicationEvent`
- `SubscribeEvent`
- `TravelBookingEvent`
- `UnlockAchievementEvent`
- `UnsubscribeEvent`
- `UpdateEvent`
- `ViewAdvEvent`
- `ViewCartEvent`
- `ViewContentEvent`
- `ViewItemEvent`
- `ViewItemsEvent`
- `InitialSubscriptionEvent`
- `InitialTrialEvent`
- `InitialOfferEvent`
- `ConvertedTrialEvent`
- `ConvertedOfferEvent`
- `TrialInRetryEvent`
- `OfferInRetryEvent`
- `SubscriptionInRetryEvent`
- `RenewedSubscriptionEvent`
- `FailedSubscriptionFromRetryEvent`
- `FailedOfferFromRetryEvent`
- `FailedTrialFromRetryEvent`
- `FailedSubscriptionEvent`
- `FailedOfferiseEvent`
- `FailedTrialEvent`
- `ReactivatedSubscriptionEvent`
- `RenewedSubscriptionFromRetryEvent`
- `ConvertedOfferFromRetryEvent`
- `ConvertedTrialFromRetryEvent`
- `UnsubscriptionEvent`

### Predefined event parameters JS

Each event can be extended with custom event parameters. By calling `addPredefinedParameter` function you can pass  [predefined parameters](#predefinedstring)

For example:

```javascript
let event = ...

event
    .addPredefinedParameter(PredefinedString.PURCHASE_CURRENCY, 'USD')
    .addPredefinedParameter(PredefinedFloat.PRICE, 2.19)
    .addPredefinedParameter(PredefinedLong.QUANTITY, 1)
    .addPredefinedParameter(PredefinedObject.CONTENT, { card: 4138, type: 'phone' })
    .addPredefinedParameter(PredefinedListObject.CONTENT_LIST, [{content:'songs'}, {content:'videos'}])
    .send(); // Send event
```

### Custom events JS

If above event functionality still limits your usecase, you can allways extend `Event` class to override fields you are missing

```javascript
class MyCustomEvent extends Event {
    constructor(args) {
        super('MyCustom', args)
    }
}
```

## SDK to SDK integrations

### AdMob

For more information how to setup, please check [official docs](https://developers.google.com/admob/ios/impression-level-ad-revenue#implementing_paid_event_handler)

```swift
var rewardedAd: GADRewardedAd?

func requestRewardedAd() {
    GADRewardedAd.load(withAdUnitID: "AD_UNIT_ID", request: GADRequest()) { (ad, error) in
        if let error = error {
            print("Rewarded ad failed to load with error: \(error.localizedDescription)")
            return
        }
        rewardedAd = ad
        rewardedAd?.paidEventHandler = { adValue in
            let responseInfo = ad?.responseInfo
            let loadedAdNetworkResponseInfo = responseInfo?.loadedAdNetworkResponseInfo

            // Send AdRevenue info
            AffiseAdRevenue(AffiseAdSource.ADMOB)
                .setRevenue(adValue.value / 1000000, adValue.currencyCode)
                .setNetwork(loadedAdNetworkResponseInfo?.adSourceName)
                .setUnit(ad?.adUnitID)
                .send()
        }
    }
}
```

### AppLovin MAX

For more information how to setup, please check [official docs](https://dash.applovin.com/documentation/mediation/ios/getting-started/advanced-settings#impression-level-user-revenue-api)

```swift
func didPayRevenue(_ ad: MAAd)
{
    // Send AdRevenue info
    AffiseAdRevenue(AffiseAdSource.APPLOVIN_MAX)
        .setRevenue(ad.revenue, "USD")
        .setNetwork(ad.networkName)
        .setUnit(ad.adUnitIdentifier)
        .setPlacement(ad.placement)
        .send()
}
```

### Helium by Chartboost

For more information how to setup, please check [official docs](https://developers.chartboost.com/docs/mediation-ios-configure-helium#implementation)

```swift
func ilrdObserverInit() {
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(didReceiveILRDNotification),
        name: .heliumDidReceiveILRD,
        object: nil
    )
}

@objc 
func didReceiveILRDNotification(notification: Notification) {
    // Extract the ILRD payload.
    guard let ilrd = notification.object as? HeliumImpressionData else {
        return
    }

    let json = ilrd.jsonData

    guard let revenue = json["ad_revenue"] else {
        return
    }

    guard let currency = json["currency_type"] else {
        return
    }

    // Send AdRevenue info
    AffiseAdRevenue(AffiseAdSource.HELIUM_CHARTBOOST)
        .setRevenue(revenue, currency)
        .setNetwork(json["network_name"])
        .setUnit(json["placement_name"])
        .setPlacement(json["line_item_name"])
        .send()
}
```

### ironSource

For more information how to setup, please check [official docs](https://developers.is.com/ironsource-mobile/ios/ad-revenue-measurement-integration/#step-2)

```swift
func impressionDataDidSucceed(impressionData: ISImpressionData) {
    guard let revenue: NSNumber = impressionData.revenue else {
        return
    }
    let ad_network: String? = impressionData.ad_network
    let all_data: NSDictionary? = impressionData.all_data

    // Send AdRevenue info
    AffiseAdRevenue(AffiseAdSource.IRONSOURCE)
        .setRevenue(revenue.doubleValue, "USD")
        .setNetwork(impressionData.ad_network)
        .setUnit(impressionData.ad_unit)
        .setPlacement(impressionData.placement)
        .send()
}
```

## Custom

### ConversionId

Adds 3 PredefinedString values: `PredefinedString.CONVERSION_ID`, `PredefinedString.ORDER_ID`, `PredefinedString.PRODUCT_ID`

> `CONVERSION_ID` = `ORDER_ID`_`PRODUCT_ID`

```swift
let event = AddToCartEvent()

let conversionId = event.customPredefined().conversionId("ORDER_ID", "PRODUCT_ID")

Affise.sendEvent(event)
```

# Debug

## Validate credentials

> [!CAUTION]
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
> 
> Debug methods WON'T work on Production
>
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

Validate your credentials by receiving `ValidationStatus` values:

- `VALID` - your credentials are valid
- `INVALID_APP_ID` - your app id is not valid 
- `INVALID_SECRET_KEY` - your SDK secretKey is not valid
- `PACKAGE_NAME_NOT_FOUND` - your application package name not found
- `NOT_WORKING_ON_PRODUCTION` - you using debug method on production
- `NETWORK_ERROR` - network or server not available (for example `Airoplane mode` is active)

```swift
Affise
    .settings(
        affiseAppId: "Your appId",
        secretKey: "Your secretKey" 
    )
    .setProduction(false) //To enable debug methods set Production to false
    .start(app: application, launchOptions: launchOptions) // Start Affise SDK

Affise.Debug.validate { status in
    // Handle validation status
}
```

## Version

Get Affise library version

```swift
Affise.Debug.version()
```

# Troubleshoots

> [!CAUTION]
> 
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥
>
> This app has crashed because it attempted to access privacy-sensitive data without a usage description.
> 
> The app's `Info.plist` must contain an `NSUserTrackingUsageDescription` key with a string value explaining
> 
> to the user how the app uses this data.
> 
> 🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥🟥

Open `info.plist` and add key `NSUserTrackingUsageDescription` with string value. For more information [read requirements](#requirements)
