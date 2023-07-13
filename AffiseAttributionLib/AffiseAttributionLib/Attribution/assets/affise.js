var Affise = class {
  static sendEvent(event) {
    window.webkit.messageHandlers.AffiseBridge.postMessage(
      JSON.stringify(event)
    );
  }
};

const AffiseLog = class {
  static d(message) {
    this._log("debug", message);
  }
  static e(message) {
    this._log("error", message);
  }
  static w(message) {
    this._log("warning", message);
  }
  static i(message) {
    this._log("info", message);
  }
  static _log(level, message) {
    window.webkit.messageHandlers.AffiseLog.postMessage({
      level: level,
      message: JSON.stringify(message),
    });
  }
};

const PredefinedString = {
  ADREV_AD_TYPE: "affise_p_adrev_ad_type",
  CITY: "affise_p_city",
  COUNTRY: "affise_p_country",
  REGION: "affise_p_region",
  CLASS: "affise_p_class",
  CONTENT_ID: "affise_p_content_id",
  CONTENT_TYPE: "affise_p_content_type",
  CURRENCY: "affise_p_currency",
  CUSTOMER_USER_ID: "affise_p_customer_user_id",
  DESCRIPTION: "affise_p_description",
  DESTINATION_A: "affise_p_destination_a",
  DESTINATION_B: "affise_p_destination_b",
  DESTINATION_LIST: "affise_p_destination_list",
  ORDER_ID: "affise_p_order_id",
  PAYMENT_INFO_AVAILABLE: "affise_p_payment_info_available",
  PREFERRED_NEIGHBORHOODS: "affise_p_preferred_neighborhoods",
  PURCHASE_CURRENCY: "affise_p_purchase_currency",
  RECEIPT_ID: "affise_p_receipt_id",
  REGISTRATION_METHOD: "affise_p_registration_method",
  SEARCH_STRING: "affise_p_search_string",
  SUBSCRIPTION_ID: "affise_p_subscription_id",
  SUCCESS: "affise_p_success",
  SUGGESTED_DESTINATIONS: "affise_p_suggested_destinations",
  SUGGESTED_HOTELS: "affise_p_suggested_hotels",
  VALIDATED: "affise_p_validated",
  ACHIEVEMENT_ID: "affise_p_achievement_id",
  COUPON_CODE: "affise_p_coupon_code",
  CUSTOMER_SEGMENT: "affise_p_customer_segment",
  DEEP_LINK: "affise_p_deep_link",
  NEW_VERSION: "affise_p_new_version",
  OLD_VERSION: "affise_p_old_version",
  PARAM_01: "affise_p_param_01",
  PARAM_02: "affise_p_param_02",
  PARAM_03: "affise_p_param_03",
  PARAM_04: "affise_p_param_04",
  PARAM_05: "affise_p_param_05",
  PARAM_06: "affise_p_param_06",
  PARAM_07: "affise_p_param_07",
  PARAM_08: "affise_p_param_08",
  PARAM_09: "affise_p_param_09",
  PARAM_10: "affise_p_param_10",
  REVIEW_TEXT: "affise_p_review_text",
  TUTORIAL_ID: "affise_p_tutorial_id",
  VIRTUAL_CURRENCY_NAME: "affise_p_virtual_currency_name",
  STATUS: "affise_p_status",
};

const PredefinedLong = {
  DATE_A: "affise_p_date_a",
  DATE_B: "affise_p_date_b",
  DEPARTING_ARRIVAL_DATE: "affise_p_departing_arrival_date",
  DEPARTING_DEPARTURE_DATE: "affise_p_departing_departure_date",
  HOTEL_SCORE: "affise_p_hotel_score",
  LEVEL: "affise_p_level",
  MAX_RATING_VALUE: "affise_p_max_rating_value",
  NUM_ADULTS: "affise_p_num_adults",
  NUM_CHILDREN: "affise_p_num_children",
  NUM_INFANTS: "affise_p_num_infants",
  PREFERRED_NUM_STOPS: "affise_p_preferred_num_stops",
  PREFERRED_STAR_RATINGS: "affise_p_preferred_star_ratings",
  QUANTITY: "affise_p_quantity",
  RATING_VALUE: "affise_p_rating_value",
  RETURNING_ARRIVAL_DATE: "affise_p_returning_arrival_date",
  RETURNING_DEPARTURE_DATE: "affise_p_returning_departure_date",
  SCORE: "affise_p_score",
  TRAVEL_START: "affise_p_travel_start",
  TRAVEL_END: "affise_p_travel_end",
  USER_SCORE: "affise_p_user_score",
  EVENT_START: "affise_p_event_start",
  EVENT_END: "affise_p_event_end",
};

const PredefinedFloat = {
  PREFERRED_PRICE_RANGE: "affise_p_preferred_price_range",
  PRICE: "affise_p_price",
  REVENUE: "affise_p_revenue",
  LAT: "affise_p_lat",
  LONG: "affise_p_long",
};

const PredefinedListString = {
  CONTENT_IDS: "affise_p_content_ids",
};

const PredefinedListObject = {
  CONTENT_LIST: "affise_p_content_list",
};

const PredefinedObject = {
  CONTENT: "affise_p_content",
};

const _predefinedType = [
  {
    prop: PredefinedString,
    type: "string",
  },
  {
    prop: PredefinedLong,
    type: "number",
    isLong: true,
  },
  {
    prop: PredefinedFloat,
    type: "number",
    isFloat: true,
  },
  {
    prop: PredefinedListString,
    type: "string",
    isArray: true,
  },
  {
    prop: PredefinedListObject,
    type: "object",
    isArray: true,
  },
  {
    prop: PredefinedObject,
    type: "object",
  },
];

class _util {
  static isValidParameter(key, value, onComplete, onError) {
    let errorMsg = null;
    if (key === undefined || key === null) {
      errorMsg = `PredefinedProperty is undefined for value ${value}`;
      onError(errorMsg);
      return false;
    }
    const keyName = this._getKey(key);
    for (const prefKey in _predefinedType) {
      let obj = _predefinedType[prefKey];
      if (obj === null || obj == undefined) break;
      if (!Object.values(obj.prop).includes(key)) continue;
      return this._isValid(obj, keyName, value, onComplete, onError);
    }
    errorMsg = `PredefinedProperty: ${key} not found`;
    onError(errorMsg);
    return false;
  }

  static _isValid(obj, keyName, value, onComplete, onError) {
    let errorMsg = null;
    if (this._asArray(obj)) {
      return this._toArray(obj, keyName, value, onComplete, onError);
    } else if (this._asFloat(obj)) {
      return this._toFloat(obj, keyName, value, onComplete, onError);
    } else if (this._asLong(obj)) {
      return this._toLong(obj, keyName, value, onComplete, onError);
    } else {
      if (typeof value === obj.type) {
        onComplete(value);
        return true;
      }
      errorMsg = `property: \'${keyName}\' only support type: \'${
        obj.type
      }\', value: ${value} is type: \'${typeof value}\'`;
      onError(errorMsg);
      return false;
    }
    return false;
  }

  static _asFloat(obj) {
    return obj.isFloat !== null && obj.isFloat !== undefined && obj.isFloat;
  }

  static _asLong(obj) {
    return obj.isLong !== null && obj.isLong !== undefined && obj.isLong;
  }

  static _asArray(obj) {
    return obj.isArray !== null && obj.isArray !== undefined && obj.isArray;
  }

  static _toFloat(obj, keyName, value, onComplete, onError) {
    if (typeof value === obj.type) {
      onComplete(value);
      return true;
    }
    let errorMsg = `property: \'${keyName}\' only support type: \'${
      obj.type
    }\', value: \'${JSON.stringify(value)}\' is type: \'${typeof value}\'`;
    onError(errorMsg);
    return false;
  }

  static _toLong(obj, keyName, value, onComplete, onError) {
    if (Number.isInteger(value)) {
      onComplete(value);
      return true;
    }
    let errorMsg = `property: \'${keyName}\' only support type: \'Integer ${
      obj.type
    }\', value: \'${JSON.stringify(value)}\' is type: \'${typeof value}\'`;
    onError(errorMsg);
    return false;
  }

  static _toArray(obj, keyName, value, onComplete, onError) {
    let errorMsg = null;
    if (!Array.isArray(value)) {
      errorMsg = `property: \'${keyName}\' only support \'array of ${
        obj.type
      }\', value: \'${JSON.stringify(value)}\' is not array`;
      onError(errorMsg);
      return false;
    }
    if (value.length < 1) {
      onComplete(value);
      return true;
    }
    if (value.some((v) => Array.isArray(v))) {
      let err = value.find((f) => Array.isArray(f));
      errorMsg = `property: \'${keyName}\' only support \'array of ${
        obj.type
      }\', value: \'${JSON.stringify(err)}\' is array`;
      onError(errorMsg);
      return false;
    }
    if (value.every((v) => typeof v === obj.type)) {
      onComplete(value);
      return true;
    }
    let err = value.find((f) => typeof f !== obj.type);
    errorMsg = `property: \'${keyName}\' only support type: \'array of ${
      obj.type
    }\', value: \'${JSON.stringify(err)}\' is type: \'${typeof err}\'`;
    onError(errorMsg);
    return false;
  }

  static _getKey(value) {
    let obj;
    let result = null;
    for (const prefKey in _predefinedType) {
      obj = _predefinedType[prefKey];
      result = Object.keys(obj.prop).find((key) => obj.prop[key] === value);
      if (result === undefined || result === null) continue;
      return result;
    }
    return null;
  }
}

class AffisePropertyBuilder {
  constructor() {
    this.prefix = "affise_event";
    this.json = {};
  }
  init(name) {
    this.name = this._toSnakeCase(name);
    return this;
  }
  add(key, value) {
    this.addRaw(this._eventProperty(key), value);
    return this;
  }
  addRaw(key, value) {
    this.json[key] = value;
    return this;
  }
  build() {
    return this.json;
  }
  _eventProperty(key) {
    return `${this.prefix}${this.name}_${key}`;
  }
  _toSnakeCase(str) {
    return str.replace(/([A-Z]|\d+)/g, (letter) => `_${letter.toLowerCase()}`);
  }
}

class Event {
  constructor(name, args) {
    const defaults = { timeStampMillis: Date.now(), userData: null };
    let params = { ...defaults, ...args };

    this.affise_event_id = this._generateUUID();
    this.affise_event_name = name;
    this.affise_event_category = "web";
    this.affise_event_timestamp = Date.now();
    this.affise_event_first_for_user = false;
    this.affise_event_user_data = params.userData;
    this.affise_event_data = new AffisePropertyBuilder()
      .init(name)
      .add("timestamp", params.timeStampMillis)
      .build();
  }

  addPredefinedParameter(key, value) {
    if (typeof this.affise_parameters === "undefined") {
      this.affise_parameters = {};
    }

    _util.isValidParameter(
      key,
      value,
      (finalValue) => {
        this.affise_parameters[key] = finalValue;
      },
      (err) => {
        AffiseLog.w(`${this.affise_event_name}: ${err}`);
      }
    );
  }

  _generateUUID() {
    let d = new Date().getTime();
    let d2 =
      (typeof performance !== "undefined" &&
        performance.now &&
        performance.now() * 1000) ||
      0;
    return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) => {
      let r = Math.random() * 16;
      if (d > 0) {
        r = (d + r) % 16 | 0;
        d = Math.floor(d / 16);
      } else {
        r = (d2 + r) % 16 | 0;
        d2 = Math.floor(d2 / 16);
      }
      return (c === "x" ? r : (r & 0x3) | 0x8).toString(16);
    });
  }
}

class SubscriptionEvent extends Event {
  constructor(data, userData, subscriptionKey, subscriptionSubKey) {
    super(subscriptionKey, { userData: userData });

    let event_data = {};

    event_data[`affise_event_${subscriptionKey}_timestamp`] = Date.now();
    event_data["affise_event_type"] = subscriptionSubKey;

    for (const key in data) {
      event_data[key] = data[key];
    }

    this.affise_event_data = event_data;
  }
}

class AchieveLevelEvent extends Event {
  /**
   * Event AchieveLevel
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("AchieveLevel", args);
  }
}

class AddPaymentInfoEvent extends Event {
  /**
   * Event AddPaymentInfo
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("AddPaymentInfo", args);
  }
}

class AddToCartEvent extends Event {
  /**
   * Event AddToCart
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("AddToCart", args);
  }
}

class AddToWishlistEvent extends Event {
  /**
   * Event AddToWishlist
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("AddToWishlist", args);
  }
}

class ClickAdvEvent extends Event {
  /**
   * Event ClickAdv
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ClickAdv", args);
  }
}

class CompleteRegistrationEvent extends Event {
  /**
   * Event CompleteRegistration
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CompleteRegistration", args);
  }
}

class CompleteStreamEvent extends Event {
  /**
   * Event CompleteStream
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CompleteStream", args);
  }
}

class CompleteTrialEvent extends Event {
  /**
   * Event CompleteTrial
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CompleteTrial", args);
  }
}

class CompleteTutorialEvent extends Event {
  /**
   * Event CompleteTutorial
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CompleteTutorial", args);
  }
}
class ContactEvent extends Event {
  /**
   * Event Contact
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Contact", args);
  }
}

class ContentItemsViewEvent extends Event {
  /**
   * Event ContentItemsView
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ContentItemsView", args);
  }
}

class CustomId01Event extends Event {
  /**
   * Event CustomId01
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId01", args);
  }
}

class CustomId02Event extends Event {
  /**
   * Event CustomId02
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId02", args);
  }
}

class CustomId03Event extends Event {
  /**
   * Event CustomId03
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId03", args);
  }
}

class CustomId04Event extends Event {
  /**
   * Event CustomId04
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId04", args);
  }
}

class CustomId05Event extends Event {
  /**
   * Event CustomId05
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId05", args);
  }
}

class CustomId06Event extends Event {
  /**
   * Event CustomId06
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId06", args);
  }
}

class CustomId07Event extends Event {
  /**
   * Event CustomId07
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId07", args);
  }
}

class CustomId08Event extends Event {
  /**
   * Event CustomId08
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId08", args);
  }
}

class CustomId09Event extends Event {
  /**
   * Event CustomId09
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId09", args);
  }
}

class CustomId10Event extends Event {
  /**
   * Event CustomId10
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomId10", args);
  }
}

class CustomizeProductEvent extends Event {
  /**
   * Event CustomizeProduct
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("CustomizeProduct", args);
  }
}

class DeepLinkedEvent extends Event {
  /**
   * Event DeepLinked
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("DeepLinked", args);
  }
}

class DonateEvent extends Event {
  /**
   * Event Donate
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Donate", args);
  }
}

class FindLocationEvent extends Event {
  /**
   * Event FindLocation
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("FindLocation", args);
  }
}

class InitiateCheckoutEvent extends Event {
  /**
   * Event InitiateCheckout
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("InitiateCheckout", args);
  }
}

class InitiatePurchaseEvent extends Event {
  /**
   * Event InitiatePurchase
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("InitiatePurchase", args);
  }
}

class InitiateStreamEvent extends Event {
  /**
   * Event InitiateStream
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("InitiateStream", args);
  }
}

class InviteEvent extends Event {
  /**
   * Event Invite
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Invite", args);
  }
}

class LastAttributedTouchEvent extends Event {
  /**
   * Event LastAttributedTouch
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("LastAttributedTouch", args);
  }
}

class LeadEvent extends Event {
  /**
   * Event Lead
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Lead", args);
  }
}

class ListViewEvent extends Event {
  /**
   * Event ListView
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ListView", args);
  }
}

class LoginEvent extends Event {
  /**
   * Event Login
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Login", args);
  }
}

class OpenedFromPushNotificationEvent extends Event {
  /**
   * Event OpenedFromPushNotification
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("OpenedFromPushNotification", args);
  }
}

class PurchaseEvent extends Event {
  /**
   * Event Purchase
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Purchase", args);
  }
}

class RateEvent extends Event {
  /**
   * Event Rate
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Rate", args);
  }
}

class ReEngageEvent extends Event {
  /**
   * Event ReEngage
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ReEngage", args);
  }
}

class ReserveEvent extends Event {
  /**
   * Event Reserve
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Reserve", args);
  }
}

class SalesEvent extends Event {
  /**
   * Event Sales
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Sales", args);
  }
}

class ScheduleEvent extends Event {
  /**
   * Event Schedule
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Schedule", args);
  }
}

class SearchEvent extends Event {
  /**
   * Event Search
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Search", args);
  }
}

class ShareEvent extends Event {
  /**
   * Event Share
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Share", args);
  }
}

class SpendCreditsEvent extends Event {
  /**
   * Event SpendCredits
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("SpendCredits", args);
  }
}

class StartRegistrationEvent extends Event {
  /**
   * Event StartRegistration
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("StartRegistration", args);
  }
}

class StartTrialEvent extends Event {
  /**
   * Event StartTrial
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("StartTrial", args);
  }
}

class StartTutorialEvent extends Event {
  /**
   * Event StartTutorial
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("StartTutorial", args);
  }
}

class SubmitApplicationEvent extends Event {
  /**
   * Event SubmitApplication
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("SubmitApplication", args);
  }
}

class SubscribeEvent extends Event {
  /**
   * Event Subscribe
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Subscribe", args);
  }
}

class TravelBookingEvent extends Event {
  /**
   * Event TravelBooking
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("TravelBooking", args);
  }
}

class UnlockAchievementEvent extends Event {
  /**
   * Event UnlockAchievement
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("UnlockAchievement", args);
  }
}

class UnsubscribeEvent extends Event {
  /**
   * Event Unsubscribe
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Unsubscribe", args);
  }
}

class UpdateEvent extends Event {
  /**
   * Event Update
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("Update", args);
  }
}

class ViewAdvEvent extends Event {
  /**
   * Event ViewAdv
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ViewAdv", args);
  }
}

class ViewCartEvent extends Event {
  /**
   * Event ViewCart
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ViewCart", args);
  }
}

class ViewContentEvent extends Event {
  /**
   * Event ViewContent
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ViewContent", args);
  }
}

class ViewItemEvent extends Event {
  /**
   * Event ViewItem
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ViewItem", args);
  }
}

class ViewItemsEvent extends Event {
  /**
   * Event ViewItems
   *
   * @param {object} args event arguments
   * @param {string} args.userData any custom string data.
   * @param {number} args.timeStampMillis the timestamp event in milliseconds.
   */
  constructor(args) {
    super("ViewItems", args);
  }
}

class InitialSubscriptionEvent extends SubscriptionEvent {
  /**
   * Event InitialSubscription
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_activation",
      "affise_sub_initial_subscription"
    );
  }
}

class InitialTrialEvent extends SubscriptionEvent {
  /**
   * Event InitialTrial
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_activation",
      "affise_sub_initial_trial"
    );
  }
}

class InitialOfferEvent extends SubscriptionEvent {
  /**
   * Event InitialOffer
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_activation",
      "affise_sub_initial_offer"
    );
  }
}

class ConvertedTrialEvent extends SubscriptionEvent {
  /**
   * Event ConvertedTrial
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_first_conversion",
      "affise_sub_converted_trial"
    );
  }
}

class ConvertedOfferEvent extends SubscriptionEvent {
  /**
   * Event ConvertedOffer
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_first_conversion",
      "affise_sub_converted_offer"
    );
  }
}

class TrialInRetryEvent extends SubscriptionEvent {
  /**
   * Event TrialInRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_entered_billing_retry",
      "affise_sub_trial_in_retry"
    );
  }
}

class OfferInRetryEvent extends SubscriptionEvent {
  /**
   * Event OfferInRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_entered_billing_retry",
      "affise_sub_offer_in_retry"
    );
  }
}

class SubscriptionInRetryEvent extends SubscriptionEvent {
  /**
   * Event SubscriptionInRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_entered_billing_retry",
      "affise_sub_subscription_in_retry"
    );
  }
}

class RenewedSubscriptionEvent extends SubscriptionEvent {
  /**
   * Event RenewedSubscription
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_renewal",
      "affise_sub_renewed_subscription"
    );
  }
}

class FailedSubscriptionFromRetryEvent extends SubscriptionEvent {
  /**
   * Event FailedSubscriptionFromRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_cancellation",
      "affise_sub_failed_subscription_from_retry"
    );
  }
}

class FailedOfferFromRetryEvent extends SubscriptionEvent {
  /**
   * Event FailedOfferFromRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_cancellation",
      "affise_sub_failed_offer_from_retry"
    );
  }
}

class FailedTrialFromRetryEvent extends SubscriptionEvent {
  /**
   * Event FailedTrialFromRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_cancellation",
      "affise_sub_failed_trial_from_retry"
    );
  }
}

class FailedSubscriptionEvent extends SubscriptionEvent {
  /**
   * Event FailedSubscription
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_cancellation",
      "affise_sub_failed_subscription"
    );
  }
}

class FailedOfferiseEvent extends SubscriptionEvent {
  /**
   * Event FailedOfferise
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_cancellation",
      "affise_sub_failed_offer"
    );
  }
}

class FailedTrialEvent extends SubscriptionEvent {
  /**
   * Event FailedTrial
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_cancellation",
      "affise_sub_failed_trial"
    );
  }
}

class ReactivatedSubscriptionEvent extends SubscriptionEvent {
  /**
   * Event ReactivatedSubscription
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_reactivation",
      "affise_sub_reactivated_subscription"
    );
  }
}

class RenewedSubscriptionFromRetryEvent extends SubscriptionEvent {
  /**
   * Event RenewedSubscriptionFromRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_renewal_from_billing_retry",
      "affise_sub_renewed_subscription_from_retry"
    );
  }
}

class ConvertedOfferFromRetryEvent extends SubscriptionEvent {
  /**
   * Event ConvertedOfferFromRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_renewal_from_billing_retry",
      "affise_sub_converted_offer_from_retry"
    );
  }
}

class ConvertedTrialFromRetryEvent extends SubscriptionEvent {
  /**
   * Event ConvertedTrialFromRetry
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(
      data,
      userData,
      "affise_subscription_renewal_from_billing_retry",
      "affise_sub_converted_trial_from_retry"
    );
  }
}

class UnsubscriptionEvent extends SubscriptionEvent {
  /**
   * Event Unsubscription
   *
   * @param {object} data event data
   * @param {string} userData any custom string data.
   */
  constructor(data, userData) {
    super(data, userData, "affise_unsubscription", "affise_sub_unsubscription");
  }
}
