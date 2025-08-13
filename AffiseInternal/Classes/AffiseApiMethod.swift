import Foundation

@objc
public enum AffiseApiMethod: Int {
    case INIT
    case IS_INITIALIZED
//    case SEND_EVENTS // deprecated
    case SEND_EVENT
    case SEND_EVENT_NOW
    case ADD_PUSH_TOKEN
    case REGISTER_WEB_VIEW
    case UNREGISTER_WEB_VIEW
    case SET_SECRET_ID
    case SET_AUTO_CATCHING_TYPES
    case SET_OFFLINE_MODE_ENABLED
    case IS_OFFLINE_MODE_ENABLED
    case SET_BACKGROUND_TRACKING_ENABLED
    case IS_BACKGROUND_TRACKING_ENABLED
    case SET_TRACKING_ENABLED
    case IS_TRACKING_ENABLED
    case FORGET
    case SET_ENABLED_METRICS
    case CRASH_APPLICATION
    case GET_RANDOM_USER_ID
    case GET_RANDOM_DEVICE_ID
    case GET_PROVIDERS
    case IS_FIRST_RUN
    // callback
    case ON_INIT_SUCCESS_HANDLER
    case ON_INIT_ERROR_HANDLER
    case GET_REFERRER_URL_CALLBACK
    case GET_REFERRER_URL_VALUE_CALLBACK
    case GET_DEFERRED_DEEPLINK_CALLBACK
    case GET_DEFERRED_DEEPLINK_VALUE_CALLBACK
    case REGISTER_DEEPLINK_CALLBACK
    case SKAD_REGISTER_ERROR_CALLBACK
    case SKAD_POSTBACK_ERROR_CALLBACK
    // debug
    case DEBUG_VALIDATE_CALLBACK
    case DEBUG_NETWORK_CALLBACK
    case DEBUG_VERSION_NATIVE
    // builder
    case AFFISE_BUILDER
    ////////////////////////////////////////
    // modules
    ////////////////////////////////////////
    case MODULE_START
    case GET_MODULES_INSTALLED
    case GET_STATUS_CALLBACK   
    // AppsFlyer Module
    case MODULE_APPSFLYER_LOG_EVENT
    // Link Module
    case MODULE_LINK_LINK_RESOLVE_CALLBACK
    // Subscription Module
    case MODULE_SUBS_FETCH_PRODUCTS_CALLBACK
    case MODULE_SUBS_PURCHASE_CALLBACK
    // TikTok Module
    case MODULE_TIKTOK_EVENT
    ////////////////////////////////////////
    // modules
    ////////////////////////////////////////

    var value: String {
        switch self {
        case .INIT: return "init"
        case .IS_INITIALIZED: return "is_initialized"
        case .SEND_EVENT: return "send_event"
        case .SEND_EVENT_NOW: return "send_event_now"
        case .ADD_PUSH_TOKEN: return "add_push_token"
        case .REGISTER_WEB_VIEW: return "register_web_view"
        case .UNREGISTER_WEB_VIEW: return "unregister_web_view"
        case .SET_SECRET_ID: return "set_secret_id"
        case .SET_AUTO_CATCHING_TYPES: return "set_auto_catching_types"
        case .SET_OFFLINE_MODE_ENABLED: return "set_offline_mode_enabled"
        case .IS_OFFLINE_MODE_ENABLED: return "is_offline_mode_enabled"
        case .SET_BACKGROUND_TRACKING_ENABLED: return "set_background_tracking_enabled"
        case .IS_BACKGROUND_TRACKING_ENABLED: return "is_background_tracking_enabled"
        case .SET_TRACKING_ENABLED: return "set_tracking_enabled"
        case .IS_TRACKING_ENABLED: return "is_tracking_enabled"
        case .FORGET: return "forget"
        case .SET_ENABLED_METRICS: return "set_enabled_metrics"
        case .CRASH_APPLICATION: return "crash_application"
        case .GET_RANDOM_USER_ID: return "get_random_user_id"
        case .GET_RANDOM_DEVICE_ID: return "get_random_device_id"
        case .GET_PROVIDERS: return "get_providers"
        case .IS_FIRST_RUN: return "is_first_run"
        // callback
        case .ON_INIT_SUCCESS_HANDLER: return "on_init_success_handler"
        case .ON_INIT_ERROR_HANDLER: return "on_init_error_handler"
        case .GET_REFERRER_URL_CALLBACK: return "get_referrer_url_callback"
        case .GET_REFERRER_URL_VALUE_CALLBACK: return "get_referrer_url_value_callback"
        case .GET_DEFERRED_DEEPLINK_CALLBACK: return "get_deferred_deeplink_callback"
        case .GET_DEFERRED_DEEPLINK_VALUE_CALLBACK: return "get_deferred_deeplink_value_callback"
        case .REGISTER_DEEPLINK_CALLBACK: return "register_deeplink_callback"
        case .SKAD_REGISTER_ERROR_CALLBACK: return "skad_register_error_callback"
        case .SKAD_POSTBACK_ERROR_CALLBACK: return "skad_postback_error_callback"
        case .DEBUG_VALIDATE_CALLBACK: return "debug_validate_callback"
        // debug
        case .DEBUG_NETWORK_CALLBACK: return "debug_network_callback"
        case .DEBUG_VERSION_NATIVE: return "debug_version_native"
        // builder
        case .AFFISE_BUILDER: return "affise_builder"
        ////////////////////////////////////////
        // modules
        ////////////////////////////////////////
        case .MODULE_START: return "module_start"
        case .GET_MODULES_INSTALLED: return "get_modules_installed"
        case .GET_STATUS_CALLBACK: return "get_status_callback"
        // AppsFlyer Module
        case .MODULE_APPSFLYER_LOG_EVENT: return "module_appsflyer_log_event"
        // Link Module
        case .MODULE_LINK_LINK_RESOLVE_CALLBACK: return "module_link_link_resolve_callback"
        // Subscription Module
        case .MODULE_SUBS_FETCH_PRODUCTS_CALLBACK: return "module_subs_fetch_products_callback"
        case .MODULE_SUBS_PURCHASE_CALLBACK: return "module_subs_purchase_callback"
        // TikTok Module
        case .MODULE_TIKTOK_EVENT: return "module_tiktok_event"
        ////////////////////////////////////////
        // modules
        ////////////////////////////////////////
        }
    }
}

extension AffiseApiMethod: CaseIterable {
    public var method: String {
        return value
    }
    
    public static func from(_ name: String) -> AffiseApiMethod? {
        return allCases.first { name == $0.value }
    }
}
