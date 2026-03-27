import SwiftUI
import AffiseAttributionLib


@available(iOS 13.0, *)
struct EventsView: View {
    @EnvironmentObject private var appSettings: AppSettings
    
    private var listEvents: [Event] {
        if appSettings.useCustomPredefined {
            return SimpleEventsFactory().createEvents()
        } else {
            return DefaultEventsFactory().createEvents()
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(listEvents.enumerated()), id: \.offset) { _, event in
                    AffiseButton(title: title(for: event)) {
                        applyCustomPredefines(event)
                        event.send()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func title(for event: Event) -> String {
        if let subscribeEvent = event as? BaseSubscriptionEvent {
            return subscribeEvent.subtype() ?? event.getName()
        }
        
        return event.getName()
    }
    
    private func applyCustomPredefines(_ event: Event) {
        for predefined in appSettings.predefinedList {
            switch predefined.predefined {
            case let parameter as PredefinedString:
                _ = event.addPredefinedParameter(parameter, string: String(describing: predefined.data))
            case let parameter as PredefinedLong:
                if let value = longValue(from: predefined.data) {
                    _ = event.addPredefinedParameter(parameter, long: value)
                }
            case let parameter as PredefinedFloat:
                if let value = floatValue(from: predefined.data) {
                    _ = event.addPredefinedParameter(parameter, float: value)
                }
            default:
                continue
            }
        }
    }
    
    private func longValue(from value: Any) -> Int64? {
        if let value = value as? Int64 {
            return value
        }
        
        if let value = value as? Int {
            return Int64(value)
        }
        
        if let value = value as? String {
            return Int64(value)
        }
        
        return nil
    }
    
    private func floatValue(from value: Any) -> Float? {
        if let value = value as? Float {
            return value
        }
        
        if let value = value as? Double {
            return Float(value)
        }
        
        if let value = value as? String {
            return Float(value)
        }
        
        return nil
    }
}


@available(iOS 13.0, *)
struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
