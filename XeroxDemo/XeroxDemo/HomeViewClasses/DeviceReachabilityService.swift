//
//  DeviceReachabilityService.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import Foundation
import Network


final class DeviceReachabilityService {
    //    func isReachable(ip: String) -> Bool {
    //        return true
    //    }
    func checkReachability(
        ip: String,
        completion: @escaping (Bool) -> Void
    ) {

        let endpoint = NWEndpoint.Host(ip)
        let port = NWEndpoint.Port(integerLiteral: 7000) // AirPlay default

        let connection = NWConnection(
            host: endpoint,
            port: port,
            using: .tcp
        )

        connection.stateUpdateHandler = { state in
            switch state {
            case .ready:
                completion(true)
                connection.cancel()

            case .failed, .cancelled:
                completion(false)
                connection.cancel()

            default:
                break
            }
        }

        connection.start(queue: .global())
    }
}
