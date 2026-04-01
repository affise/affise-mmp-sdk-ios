import AffiseAttributionLib
import Combine
import Foundation
import SwiftUI

enum StorageKeys {
    static let domain = "domain"
    static let appId = "appId"
    static let secretKey = "secretKey"
    static let isProductionMode = "isProductionMode"
    static let isOfflineMode = "isOfflineMode"
    static let isDebugRequest = "isDebugRequest"
    static let isDebugResponse = "isDebugResponse"
    static let useCustomPredefined = "useCustomPredefined"
    static let predefinedList = "predefinedList"
}

final class AppSettings: ObservableObject {
    static let DEMO_DOMAIN = "https://webhook.site/0cba1724-5463-47b5-b60c-f15ac9a26804" // TODO dev
    static let DEFAULT_AFFISE_APP_ID = "129"
    static let DEFAULT_SECRET_KEY = "93a40b54-6f12-443f-a250-ebf67c5ee4d2"

    @AppStorage(StorageKeys.domain)
    var domain = AppSettings.DEMO_DOMAIN
    
    @AppStorage(StorageKeys.appId)
    var appId = AppSettings.DEFAULT_AFFISE_APP_ID
    
    @AppStorage(StorageKeys.secretKey)
    var secretKey = AppSettings.DEFAULT_SECRET_KEY
    
    @AppStorage(StorageKeys.isProductionMode)
    var isProductionMode = false
    
    @AppStorage(StorageKeys.isOfflineMode)
    var isOfflineMode = false
    
    @AppStorage(StorageKeys.isDebugRequest)
    var isDebugRequest = false
    
    @AppStorage(StorageKeys.isDebugResponse)
    var isDebugResponse = false
    
    @AppStorage(StorageKeys.useCustomPredefined)
    var useCustomPredefined = false
    
    @AppStorage(StorageKeys.predefinedList)
    private var predefinedListStorage = ""
    
    var predefinedList: [PredefinedData] {
        get {
            guard
                let data = predefinedListStorage.data(using: .utf8),
                let storedList = try? JSONDecoder().decode([StoredPredefinedData].self, from: data)
            else {
                return []
            }
            
            return storedList.compactMap { item in
                guard let predefined = parsePredefined(item.predefined) else {
                    return nil
                }
                
                return PredefinedData(predefined: predefined, data: item.data)
            }
        }
        set {
            let storedList = newValue.map {
                StoredPredefinedData(
                    predefined: $0.predefined.value(),
                    data: String(describing: $0.data)
                )
            }
            
            guard let data = try? JSONEncoder().encode(storedList),
                  let json = String(data: data, encoding: .utf8) else {
                return
            }
            
            objectWillChange.send()
            predefinedListStorage = json
        }
    }
    
    private struct StoredPredefinedData: Codable {
        let predefined: String
        let data: String
    }
    
    private func parsePredefined(_ value: String) -> (any Predefined)? {
        PredefinedFloat.from(value)
            ?? PredefinedLong.from(value)
            ?? PredefinedString.from(value)
    }
}
