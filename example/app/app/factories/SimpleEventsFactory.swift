import AffiseAttributionLib


class SimpleEventsFactory: EventsFactory {
    private let baseEvents: [Event] = [
        AchieveLevelEvent(),
        AddPaymentInfoEvent(),
        AddToCartEvent(),
        AddToWishlistEvent(),
        AdRevenueEvent(),
        ClickAdvEvent(),
        CompleteRegistrationEvent(),
        CompleteStreamEvent(),
        CompleteTrialEvent(),
        CompleteTutorialEvent(),
        ContentItemsViewEvent(),
        CustomId01Event(),
        CustomId02Event(),
        CustomId03Event(),
        CustomId04Event(),
        CustomId05Event(),
        CustomId06Event(),
        CustomId07Event(),
        CustomId08Event(),
        CustomId09Event(),
        CustomId10Event(),
        DeepLinkedEvent(),
        InitiatePurchaseEvent(),
        InitiateStreamEvent(),
        InviteEvent(),
        LastAttributedTouchEvent(),
        ListViewEvent(),
        LoginEvent(),
        OpenedFromPushNotificationEvent(),
        OrderEvent(),
        OrderItemAddedEvent(),
        OrderItemRemoveEvent(),
        OrderCancelEvent(),
        OrderReturnRequestEvent(),
        OrderReturnRequestCancelEvent(),
        PurchaseEvent(),
        RateEvent(),
        ReEngageEvent(),
        ReserveEvent(),
        SalesEvent(),
        SearchEvent(),
        ShareEvent(),
        SpendCreditsEvent(),
        StartRegistrationEvent(),
        StartTrialEvent(),
        StartTutorialEvent(),
        SubscribeEvent(),
        TravelBookingEvent(),
        UnlockAchievementEvent(),
        UnsubscribeEvent(),
        UpdateEvent(),
        ViewAdvEvent(),
        ViewCartEvent(),
        ViewItemEvent(),
        ViewItemsEvent(),
    ]
    
    private let subscriptionEvents: [Event] = [
        InitialSubscriptionEvent(),
        InitialTrialEvent(),
        InitialOfferEvent(),
        ConvertedTrialEvent(),
        ConvertedOfferEvent(),
        TrialInRetryEvent(),
        OfferInRetryEvent(),
        SubscriptionInRetryEvent(),
        RenewedSubscriptionEvent(),
        FailedSubscriptionFromRetryEvent(),
        FailedOfferFromRetryEvent(),
        FailedTrialFromRetryEvent(),
        FailedSubscriptionEvent(),
        FailedOfferiseEvent(),
        FailedTrialEvent(),
        ReactivatedSubscriptionEvent(),
        RenewedSubscriptionFromRetryEvent(),
        ConvertedOfferFromRetryEvent(),
        ConvertedTrialFromRetryEvent(),
        UnsubscriptionEvent(),
    ]
    
    func createEvents() -> [Event] {
        return [baseEvents, subscriptionEvents].flatMap { $0 }
    }
}




