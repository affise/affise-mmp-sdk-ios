//
//  ConnectionTypeProvider.swift
//  AffiseAttributionLib
//
//  Created by Sergey Korney
//

import Foundation
import SystemConfiguration


/**
 * Provides connection type [Parameters.CONNECTION_TYPE]
 */
class ConnectionTypeProvider: StringPropertyProvider {
    
    override func provide() -> String? {
        return getConnectionType()
    }
    
    private func getConnectionType() -> String? {
        guard let reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.google.com") else {
            return nil
        }

        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)

        let isReachable = flags.contains(.reachable)
        let isWWAN = flags.contains(.isWWAN)

        if isReachable {
            if isWWAN {
                return "MOBILE"
            } else {
                return "WIFI"
            }
        } else {
            return nil
        }
    }
    
    public override func getOrder() -> Float {
        21.1
    }

    public override func getKey() -> String? {
        Parameters.CONNECTION_TYPE
    }
}
