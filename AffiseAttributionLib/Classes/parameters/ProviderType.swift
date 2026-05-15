import Foundation

@objc
public enum ProviderType: Int {
    case AFFISE_APP_ID
    case AFFISE_PKG_APP_NAME
    case AFF_APP_NAME_DASHBOARD
    case APP_VERSION
    case APP_VERSION_RAW
    case STORE
    case TRACKER_TOKEN
    case TRACKER_NAME
    case FIRST_TRACKER_TOKEN
    case FIRST_TRACKER_NAME
    case LAST_TRACKER_TOKEN
    case LAST_TRACKER_NAME
    case OUTDATED_TRACKER_TOKEN
    case INSTALLED_TIME
    case FIRST_OPEN_TIME
    case INSTALLED_HOUR
    case FIRST_OPEN_HOUR
    case INSTALL_FIRST_EVENT
    case INSTALL_BEGIN_TIME
    case INSTALL_FINISH_TIME
    case REFERRER_INSTALL_VERSION
    case REFERRAL_TIME
    case REFERRER_CLICK_TIME
    case REFERRER_CLICK_TIME_SERVER
    case REFERRER_GOOGLE_PLAY_INSTANT
    case CREATED_TIME
    case CREATED_TIME_MILLI
    case CREATED_TIME_HOUR
    case UNINSTALL_TIME
    case REINSTALL_TIME
    case LAST_SESSION_TIME
    case CPU_TYPE
    case HARDWARE_NAME
    case DEVICE_MANUFACTURER
    case DEEPLINK_CLICK
    case DEVICE_ATLAS_ID
    case AFFISE_DEVICE_ID
    case AFFISE_ALT_DEVICE_ID
    case ANDROID_ID
    case ANDROID_ID_MD5
    case REFTOKEN
    case REFTOKENS
    case REFERRER
    case USER_AGENT
    case MCCODE
    case MNCODE
    case REGION
    case COUNTRY
    case LANGUAGE
    case DEVICE_NAME
    case DEVICE_TYPE
    case OS_NAME
    case PLATFORM
    case SDK_PLATFORM
    case API_LEVEL_OS
    case AFFISE_SDK_VERSION
    case OS_VERSION
    case RANDOM_USER_ID
    case AFFISE_SDK_POS
    case TIMEZONE_DEV
    case AFFISE_EVENT_NAME
    case AFFISE_EVENT_TOKEN
    case LAST_TIME_SESSION
    case TIME_SESSION
    case AFFISE_SESSION_COUNT
    case LIFETIME_SESSION_COUNT
    case AFFISE_DEEPLINK
    case AFFISE_PART_PARAM_NAME
    case AFFISE_PART_PARAM_NAME_TOKEN
    case AFFISE_APP_TOKEN
    case LABEL
    case AFFISE_SDK_SECRET_ID
    case UUID
    case AFFISE_APP_OPENED
    case PUSHTOKEN
    case PUSHTOKEN_SERVICE
    case AFFISE_EVENTS_COUNT
    case AFFISE_SDK_EVENTS_COUNT
    case AFFISE_METRICS_EVENTS_COUNT
    case AFFISE_INTERNAL_EVENTS_COUNT
    case IS_ROOTED
    case IS_EMULATOR
    case IDFV

    // remarketing
    case OS_AND_VERSION
    case DEVICE
    case BUILD

    // adservice
    case AD_SERVICE_ATTRIBUTION

    // advertising
    case GAID_ADID
    case GAID_ADID_MD5
    case OAID
    case OAID_MD5
    case ADID
    case ALTSTR_ADID
    case FIREOS_ADID
    case COLOROS_ADID
    
    // network
    case MAC_SHA1
    case MAC_MD5
    case CONNECTION_TYPE
    case PROXY_IP_ADDRESS
    
    // phone
    case NETWORK_TYPE
    case ISP
    
    public var provider: String {
        switch self {
        case .AFFISE_APP_ID: return "affise_app_id"
        case .AFFISE_PKG_APP_NAME: return "affise_pkg_app_name"
        case .AFF_APP_NAME_DASHBOARD: return "affise_app_name_dashboard"
        case .APP_VERSION: return "app_version"
        case .APP_VERSION_RAW: return "app_version_raw"
        case .STORE: return "store"
        case .TRACKER_TOKEN: return "tracker_token"
        case .TRACKER_NAME: return "tracker_name"
        case .FIRST_TRACKER_TOKEN: return "first_tracker_token"
        case .FIRST_TRACKER_NAME: return "first_tracker_name"
        case .LAST_TRACKER_TOKEN: return "last_tracker_token"
        case .LAST_TRACKER_NAME: return "last_tracker_name"
        case .OUTDATED_TRACKER_TOKEN: return "outdated_tracker_token"
        case .INSTALLED_TIME: return "installed_time"
        case .FIRST_OPEN_TIME: return "first_open_time"
        case .INSTALLED_HOUR: return "installed_hour"
        case .FIRST_OPEN_HOUR: return "first_open_hour"
        case .INSTALL_FIRST_EVENT: return "install_first_event"
        case .INSTALL_BEGIN_TIME: return "install_begin_time"
        case .INSTALL_FINISH_TIME: return "install_finish_time"
        case .REFERRER_INSTALL_VERSION: return "referrer_install_version"
        case .REFERRAL_TIME: return "referral_time"
        case .REFERRER_CLICK_TIME: return "referrer_click_time"
        case .REFERRER_CLICK_TIME_SERVER: return "referrer_click_time_server"
        case .REFERRER_GOOGLE_PLAY_INSTANT: return "referrer_google_play_instant"
        case .CREATED_TIME: return "created_time"
        case .CREATED_TIME_MILLI: return "created_time_milli"
        case .CREATED_TIME_HOUR: return "created_time_hour"
        case .UNINSTALL_TIME: return "uninstall_time"
        case .REINSTALL_TIME: return "reinstall_time"
        case .LAST_SESSION_TIME: return "last_session_time"
        case .CPU_TYPE: return "cpu_type"
        case .HARDWARE_NAME: return "hardware_name"
        case .DEVICE_MANUFACTURER: return "device_manufacturer"
        case .DEEPLINK_CLICK: return "deeplink_click"
        case .DEVICE_ATLAS_ID: return "device_atlas_id"
        case .AFFISE_DEVICE_ID: return "affise_device_id"
        case .AFFISE_ALT_DEVICE_ID: return "affise_alt_device_id"
        case .ANDROID_ID: return "android_id"
        case .ANDROID_ID_MD5: return "android_id_md5"
        case .REFTOKEN: return "reftoken"
        case .REFTOKENS: return "reftokens"
        case .REFERRER: return "referrer"
        case .USER_AGENT: return "user_agent"
        case .MCCODE: return "mccode"
        case .MNCODE: return "mncode"
        case .REGION: return "region"
        case .COUNTRY: return "country"
        case .LANGUAGE: return "language"
        case .DEVICE_NAME: return "device_name"
        case .DEVICE_TYPE: return "device_type"
        case .OS_NAME: return "os_name"
        case .PLATFORM: return "platform"
        case .SDK_PLATFORM: return "sdk_platform"
        case .API_LEVEL_OS: return "api_level_os"
        case .AFFISE_SDK_VERSION: return "affise_sdk_version"
        case .OS_VERSION: return "os_version"
        case .RANDOM_USER_ID: return "random_user_id"
        case .AFFISE_SDK_POS: return "affise_sdk_pos"
        case .TIMEZONE_DEV: return "timezone_dev"
        case .AFFISE_EVENT_NAME: return "affise_event_name"
        case .AFFISE_EVENT_TOKEN: return "affise_event_token"
        case .LAST_TIME_SESSION: return "last_time_session"
        case .TIME_SESSION: return "time_session"
        case .AFFISE_SESSION_COUNT: return "affise_session_count"
        case .LIFETIME_SESSION_COUNT: return "lifetime_session_count"
        case .AFFISE_DEEPLINK: return "affise_deeplink"
        case .AFFISE_PART_PARAM_NAME: return "affise_part_param_name"
        case .AFFISE_PART_PARAM_NAME_TOKEN: return "affise_part_param_name_token"
        case .AFFISE_APP_TOKEN: return "affise_app_token"
        case .LABEL: return "label"
        case .AFFISE_SDK_SECRET_ID: return "affise_sdk_secret_id"
        case .UUID: return "uuid"
        case .AFFISE_APP_OPENED: return "affise_app_opened"
        case .PUSHTOKEN: return "pushtoken"
        case .PUSHTOKEN_SERVICE: return "pushtoken_service"
        case .AFFISE_EVENTS_COUNT: return "affise_events_count"
        case .AFFISE_SDK_EVENTS_COUNT: return "affise_sdk_events_count"
        case .AFFISE_METRICS_EVENTS_COUNT: return "affise_metrics_events_count"
        case .AFFISE_INTERNAL_EVENTS_COUNT: return "affise_internal_events_count"
        case .IS_ROOTED: return "is_rooted"
        case .IS_EMULATOR: return "is_emulator"
        case .IDFV: return "idfv"
        
        // remarketing
        case .OS_AND_VERSION: return "os_and_version"
        case .DEVICE: return "device"
        case .BUILD: return "build"

        // adservice
        case .AD_SERVICE_ATTRIBUTION: return "ad_service_attribution"

        // advertising
        case .GAID_ADID: return "gaid_adid"
        case .GAID_ADID_MD5: return "gaid_adid_md5"
        case .OAID: return "oaid"
        case .OAID_MD5: return "oaid_md5"
        case .ADID: return "adid"
        case .ALTSTR_ADID: return "altstr_adid"
        case .FIREOS_ADID: return "fireos_adid"
        case .COLOROS_ADID: return "coloros_adid"

            
        // network
        case .MAC_SHA1: return "mac_sha1"
        case .MAC_MD5: return "mac_md5"
        case .CONNECTION_TYPE: return "connection_type"
        case .PROXY_IP_ADDRESS: return "proxy_ip_address"
            
        // phone
        case .NETWORK_TYPE: return "network_type"
        case .ISP: return "isp"
        }
    }
}

extension ProviderType: CaseIterable {
    
    public static func from(_ name: String?) -> ProviderType? {
        if name == nil {return nil }
        return allCases.first { name == $0.provider }
    }
}


