//
//  NetworkReachability.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import Foundation
import Network

enum NetworkReachability {
    static var isReachable: Bool {
        NWPathMonitor().currentPath.status == .satisfied
    }
}
