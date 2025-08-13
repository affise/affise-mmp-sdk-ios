import AffiseAttributionLib
import Foundation
import UIKit

@objc
public class AffiseApiWrapper: NSObject {
    private let UUID: String = "callback_uuid"
    private let TAG: String = "callback_tag"

    private let factory = AffiseEventFactory()
    private let affiseBuilder = AffiseBuilder()

    public typealias OnCallback = (_ api: String, _ data: [String: Any?]) -> Void
    public typealias OnAffiseCallback = (_ api: String, _ data: String) -> Void

    private var callback: OnCallback? = nil

    private var app: UIApplication? = nil
    private var launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil

    @objc(app:launchOptions:)
    public init(_ app: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.app = app
        self.launchOptions = launchOptions
    }

    @objc(callback:)
    public func setCallback(_ callback: @escaping OnAffiseCallback) {
        self.callback = { apiName, map in
            callback(apiName, map.toArray().jsonString())
        }
    }

    public func setCallback(_ callback: @escaping OnCallback) {
        self.callback = callback
    }

    @objc(deeplink:)
    public func handleDeeplink(_ link: String?) {
        InternalCrossPlatform.deeplink(link ?? "")
    }

    @objc(react)
    public func react() {
        InternalCrossPlatform.react()
    }

    @objc(flutter)
    public func flutter() {
        InternalCrossPlatform.flutter()
    }

    @objc(unity)
    public func unity() {
        InternalCrossPlatform.unity()
    }

    @objc(call:map:result:)
    public func call(_ name: String, map: [String: AnyObject], result: InternalResult?) {
        guard let api = AffiseApiMethod.from(name) else {
            return
        }
        call(api, map: map, result: result)
    }

    public func call(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        switch api {
        case .INIT: callInit(api, map: map, result: result)
        case .IS_INITIALIZED: callIsInitialized(api, map: map, result: result)
        case .SEND_EVENT: callSendEvent(api, map: map, result: result)
        case .SEND_EVENT_NOW: callSendEventNow(api, map: map, result: result)
        case .ADD_PUSH_TOKEN: callAddPushToken(api, map: map, result: result)
        case .REGISTER_WEB_VIEW: callRegisterWebView(api, map: map, result: result)
        case .UNREGISTER_WEB_VIEW: callUnregisterWebView(api, map: map, result: result)
        case .SET_SECRET_ID: callSetSecretId(api, map: map, result: result)
        case .SET_AUTO_CATCHING_TYPES: callSetAutoCatchingTypes(api, map: map, result: result)
        case .SET_OFFLINE_MODE_ENABLED: callSetOfflineModeEnabled(api, map: map, result: result)
        case .IS_OFFLINE_MODE_ENABLED: callIsOfflineModeEnabled(api, map: map, result: result)
        case .SET_BACKGROUND_TRACKING_ENABLED: callSetBackgroundTrackingEnabled(api, map: map, result: result)
        case .IS_BACKGROUND_TRACKING_ENABLED: callIsBackgroundTrackingEnabled(api, map: map, result: result)
        case .SET_TRACKING_ENABLED: callSetTrackingEnabled(api, map: map, result: result)
        case .IS_TRACKING_ENABLED: callIsTrackingEnabled(api, map: map, result: result)
        case .FORGET: callForget(api, map: map, result: result)
        case .SET_ENABLED_METRICS: callSetEnabledMetrics(api, map: map, result: result)
        case .CRASH_APPLICATION: callCrashApplication(api, map: map, result: result)
        case .GET_RANDOM_USER_ID: callGetRandomUserId(api, map: map, result: result)
        case .GET_RANDOM_DEVICE_ID: callGetRandomDeviceId(api, map: map, result: result)
        case .GET_PROVIDERS: callGetProviders(api, map: map, result: result)
        case .IS_FIRST_RUN: callIsFirstRun(api, map: map, result: result)
        // callback
        case .GET_REFERRER_URL_CALLBACK: callGetReferrerUrl(api, map: map, result: result)
        case .GET_REFERRER_URL_VALUE_CALLBACK: callGetReferrerUrlValue(api, map: map, result: result)
        case .GET_DEFERRED_DEEPLINK_CALLBACK: callGetDeferredDeeplink(api, map: map, result: result)
        case .GET_DEFERRED_DEEPLINK_VALUE_CALLBACK: callGetDeferredDeeplinkValue(api, map: map, result: result)
        case .REGISTER_DEEPLINK_CALLBACK: callRegisterDeeplinkCallback(api, map: map, result: result)
        case .SKAD_REGISTER_ERROR_CALLBACK: callSkadRegisterErrorCallback(api, map: map, result: result)
        case .SKAD_POSTBACK_ERROR_CALLBACK: callSkadPostbackErrorCallback(api, map: map, result: result)
        // debug
        case .DEBUG_VALIDATE_CALLBACK: callDebugValidateCallback(api, map: map, result: result)
        case .DEBUG_NETWORK_CALLBACK: callDebugNetworkCallback(api, map: map, result: result)
        case .DEBUG_VERSION_NATIVE: callDebugVersionNative(api, map: map, result: result)
        // builder
        case .AFFISE_BUILDER: callAffiseBuilder(api, map: map, result: result)

        ////////////////////////////////////////
        // modules
        ////////////////////////////////////////
        case .MODULE_START: callModuleStart(api, map: map, result: result)
        case .GET_MODULES_INSTALLED: callGetModulesInstalled(api, map: map, result: result)
        case .GET_STATUS_CALLBACK: callGetStatusCallback(api, map: map, result: result)
        
        // AppsFlyer Module
        case .MODULE_APPSFLYER_LOG_EVENT: callModuleAppsFlyerLogEvent(api, map: map, result: result)

        // Link Module
        case .MODULE_LINK_LINK_RESOLVE_CALLBACK: callModuleLinkLinkResolveCallback(api, map: map, result: result)
        
        // Subscription Module
        case .MODULE_SUBS_FETCH_PRODUCTS_CALLBACK: callModuleSubsFetchProductsCallback(api, map: map, result: result)
        case .MODULE_SUBS_PURCHASE_CALLBACK: callModuleSubsPurchaseCallback(api, map: map, result: result)

        // TikTok Module
        case .MODULE_TIKTOK_EVENT: callModuleTikTokEvent(api, map: map, result: result)
        ////////////////////////////////////////
        // modules
        ////////////////////////////////////////
        default:
            result?.notImplemented()
        }
    }

    private func callInit(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let app = app else {
            result?.error("api [\(api.method)]: no application context")
            return
        }

        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        if !data.isValid() {
            result?.error("api [\(api.method)]: affiseAppId or secretKey is not set")
            return
        }

        let (affiseAppId, secretKey) = data.getAppIdAndSecretKey()

        Affise
            .settings(
                affiseAppId: affiseAppId,
                secretKey: secretKey
            )
            .setOnInitSuccess {
                let data: [String: Any?] = [:]
                self.callback?(AffiseApiMethod.ON_INIT_SUCCESS_HANDLER.method, data)
            }
            .setOnInitError{ error in
                let data: [String: Any?] = [
                    AffiseApiMethod.ON_INIT_ERROR_HANDLER.method: error.localizedDescription,
                ]
                self.callback?(AffiseApiMethod.ON_INIT_SUCCESS_HANDLER.method, data)
            }
            .addSettings(data)
            .start(app: app, launchOptions: launchOptions)

        result?.success(nil)
    }

    private func callIsInitialized(_: AffiseApiMethod, map _: [String: Any?], result: InternalResult?) {
        result?.success(Affise.isInitialized())
    }

    private func callSendEvent(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let event = factory.create(data) else {
            result?.error("api [\(api.method)]: not valid event")
            return
        }

        event.send()
        result?.success(nil)
    }

    private func callSendEventNow(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let event = factory.create(data) else {
            result?.error("api [\(api.method)]: not valid event")
            return
        }

        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        event.sendNow({
            let data: [String: Any?] = [
                self.UUID: uuid,
                self.TAG: DataName.SUCCESS,
            ]
            self.callback?(api.method, data)
        }) { response in
            let data: [String: Any?] = [
                self.UUID: uuid,
                self.TAG: DataName.FAILED,
                api.method: [
                    DataName.CODE: response.code,
                    DataName.MESSAGE: response.message,
                    DataName.BODY: "\(response.body?.toJsonGuardString() ?? "")",
                ],
            ]
            self.callback?(api.method, data)
        }

        result?.success(nil)
    }

    private func callAddPushToken(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let pushToken: String = data.opt(DataName.PUSH_TOKEN) else {
            result?.error("api [\(api.method)]: push token not set")
            return
        }

        guard let pushTokenService: PushTokenService = PushTokenService.from(data.opt(DataName.PUSH_TOKEN_SERVICE)) else {
            result?.error("api [\(api.method)]: push token service not set")
            return
        }

        if pushToken.isEmpty {
            result?.error("api [\(api.method)]: push token value not set")
        } else {
            Affise.addPushToken(pushToken, pushTokenService)
            result?.success(nil)
        }
    }

    private func callRegisterWebView(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        // Affise.registerWebView(webView)
        result?.notImplemented()
    }

    private func callUnregisterWebView(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        // Affise.unregisterWebView()
        result?.notImplemented()
    }

    private func callSetSecretId(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let secretKey: String = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        Affise.setSecretKey(secretKey)
        result?.success(nil)
    }

    private func callSetAutoCatchingTypes(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.notImplemented()
    }

    private func callSetOfflineModeEnabled(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let enabled: Bool = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        Affise.setOfflineModeEnabled(enabled)
        result?.success(nil)
    }

    private func callIsOfflineModeEnabled(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.success(Affise.isOfflineModeEnabled())
    }

    private func callSetBackgroundTrackingEnabled(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let enabled: Bool = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        Affise.setBackgroundTrackingEnabled(enabled)
        result?.success(nil)
    }

    func callIsBackgroundTrackingEnabled(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.success(Affise.isBackgroundTrackingEnabled())
    }

    private func callSetTrackingEnabled(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let enabled: Bool = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        Affise.setTrackingEnabled(enabled)
        result?.success(nil)
    }

    private func callIsTrackingEnabled(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.success(Affise.isTrackingEnabled())
    }

    private func callForget(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.notImplemented()
    }

    private func callSetEnabledMetrics(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.notImplemented()
    }

    private func callCrashApplication(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.notImplemented()
    }

    private func callGetRandomUserId(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.success(Affise.getRandomUserId())
    }

    private func callGetRandomDeviceId(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        result?.success(Affise.getRandomDeviceId())
    }

    private func callGetProviders(_: AffiseApiMethod, map _: [String: Any?]?, result: InternalResult?) {
        let data: [String: Any?] = Affise.getProviders().reduce(into: [:]) { dict, provider in
            dict[provider.key.provider] = provider.value
        }
        result?.success(data)
    }

    private func callIsFirstRun(_: AffiseApiMethod, map _: [String: Any?], result: InternalResult?) {
        result?.success(Affise.isFirstRun())
    }

    private func callGetReferrerUrl(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        Affise.getReferrerUrl { referrer in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: referrer,
            ]
            self.callback?(api.method, data)
        }

        result?.success(nil)
    }

    private func callGetReferrerUrlValue(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        guard let name: String = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let key = ReferrerKey.from(name) else {
            result?.error("api [\(api.method)]: no valid ReferrerKey")
            return
        }

        Affise.getReferrerUrlValue(key) { value in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: value,
            ]
            self.callback?(api.method, data)
        }

        result?.success(nil)
    }

    private func callGetDeferredDeeplink(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        Affise.getDeferredDeeplink { referrer in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: referrer,
            ]
            self.callback?(api.method, data)
        }

        result?.success(nil)
    }

    private func callGetDeferredDeeplinkValue(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        guard let name: String = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let key = ReferrerKey.from(name) else {
            result?.error("api [\(api.method)]: no valid ReferrerKey")
            return
        }

        Affise.getDeferredDeeplinkValue(key) { value in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: value,
            ]
            self.callback?(api.method, data)
        }

        result?.success(nil)
    }

    private func callRegisterDeeplinkCallback(_ api: AffiseApiMethod, map _: [String: Any?], result: InternalResult?) {
        Affise.registerDeeplinkCallback { value in
            let data: [String: Any?] = [
                api.method: DataMapper.fromDeeplinkValue(value),
            ]
            self.callback?(api.method, data)
        }
        result?.success(nil)
    }

    private func callSkadRegisterErrorCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        SKAdWrapper.register(result) { error in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: error,
            ]
            self.callback?(api.method, data)
        }
    }

    private func callSkadPostbackErrorCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let fineValue: NSNumber = data.opt(DataName.FINE_VALUE) else {
            result?.error("api [\(api.method)]: fineValue not set")
            return
        }

        let coarseValue: String? = data.opt(DataName.COARSE_VALUE)

        SKAdWrapper.postback(result, fineValue: fineValue.intValue, coarseValue: coarseValue) { error in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: error,
            ]
            self.callback?(api.method, data)
        }
    }

    private func callDebugValidateCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        Affise.Debug.validate { status in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: status.status,
            ]
            self.callback?(api.method, data)
        }
    }

    private func callDebugNetworkCallback(_ api: AffiseApiMethod, map _: [String: Any?], result _: InternalResult?) {
        Affise.Debug.network { request, response in
            let data: [String: Any?] = [
                api.method: [
                    DataName.REQUEST: DataMapper.fromRequest(request),
                    DataName.RESPONSE: DataMapper.fromResponse(response),
                ],
            ]
            self.callback?(api.method, data)
        }
    }

    private func callDebugVersionNative(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        result?.success(Affise.Debug.version())
    }

    private func callAffiseBuilder(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        affiseBuilder.call(api, map, result)
    }

    ////////////////////////////////////////
    // modules
    ////////////////////////////////////////
    private func callModuleStart(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let name: String = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let module = AffiseModules.from(name) else {
            result?.error("api [\(api.method)]: no valid AffiseModules")
            return
        }

        result?.success(Affise.Module.moduleStart(module))
    }

    private func callGetModulesInstalled(_: AffiseApiMethod, map _: [String: Any?], result: InternalResult?) {
        let data: [String] = Affise.Module.getModulesInstalled().map { $0.description }
        result?.success(data)
    }

    private func callGetStatusCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        guard let name: String = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        guard let module = AffiseModules.from(name) else {
            result?.error("api [\(api.method)]: no valid AffiseModules")
            return
        }

        Affise.Module.getStatus(module) { status in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: status.toListOfMap(),
            ]
            self.callback?(api.method, data)
        }
        result?.success(nil)
    }

    // AppsFlyer Module
    private func callModuleAppsFlyerLogEvent(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) { 
        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: no valid data")
            return
        }

        guard let eventName: String = data.opt(DataName.EVENT_NAME) else {
            result?.error("api [\(api.method)]: eventName not set")
            return
        }

        let eventValues: [String:Any]? = data.opt(DataName.EVENT_VALUES)

        Affise.Module.AppsFlyer.logEvent(eventName, eventValues ?? [:])
        result?.success(nil)
    }

    // Link Module
    private func callModuleLinkLinkResolveCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        guard let url: String = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        Affise.Module.Link.resolve(url) { redirectUrl in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: redirectUrl,
            ]
            self.callback?(api.method, data)
        }
        result?.success(nil)
    }

    // Subscription Module
    private func callModuleSubsFetchProductsCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        guard let ids: [String] = map.opt(api) else {
            result?.error("api [\(api.method)]: value not set")
            return
        }

        Affise.Module.Subscription.fetchProducts(ids) { fetchResult in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: DataMapper.fromFetchProductsResult(fetchResult),
            ]
            self.callback?(api.method, data)
        }
        result?.success(nil)
    }

    private func callModuleSubsPurchaseCallback(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) {
        guard let uuid: String = map.opt(UUID) else {
            result?.error("api [\(api.method)]: no valid Callback UUID")
            return
        }

        let data: [String: Any?]? = map.opt(api)

        guard let product: AffiseProduct = DataMapper.toAffiseProduct(data?.opt(DataName.PRODUCT)) else {
            result?.error("api [\(api.method)]: product not set")
            return
        }
        
        let type: AffiseProductType? = DataMapper.toAffiseProductType(data?.opt(DataName.TYPE))

        Affise.Module.Subscription.purchase(product, type) { purchaseResult in
            let data: [String: Any?] = [
                self.UUID: uuid,
                api.method: DataMapper.fromPurchaseResult(purchaseResult),
            ]
            self.callback?(api.method, data)
        }
        result?.success(nil)
    }

    // TikTok Module
    private func callModuleTikTokEvent(_ api: AffiseApiMethod, map: [String: Any?], result: InternalResult?) { 
        guard let data: [String: Any?] = map.opt(api) else {
            result?.error("api [\(api.method)]: no valid data")
            return
        }

        guard let eventName: String = data.opt(DataName.EVENT_NAME) else {
            result?.error("api [\(api.method)]: eventName not set")
            return
        }

        let properties: [AnyHashable:Any]? = data.opt(DataName.EVENT_VALUES)
        let eventId: String? = data.opt(DataName.EVENT_ID)

        Affise.Module.TikTok.sendEvent(eventName, properties: properties, eventId: eventId)
        result?.success(nil)
    }
    ////////////////////////////////////////
    // modules
    ////////////////////////////////////////
}
