//
//  MDNSDiscoveryService.swift
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

import Foundation

import Foundation

final class MDNSDiscoveryService: NSObject {
    
    private let browser = NetServiceBrowser()
    private var services: [NetService] = []
    
    var onDeviceFound: ((AirPlayDevice) -> Void)?
    
    override init() {
        super.init()
        browser.delegate = self
    }
    
    func start() {
        browser.searchForServices(ofType: "_airplay._tcp.", inDomain: "local.")
    }
    
    func stop() {
        browser.stop()
        services.removeAll()
    }
}
extension MDNSDiscoveryService: NetServiceBrowserDelegate {
    
    func netServiceBrowser(_ browser: NetServiceBrowser,
                           didFind service: NetService,
                           moreComing: Bool) {
        
        services.append(service)
        service.delegate = self
        service.resolve(withTimeout: 5)
    }
}

extension MDNSDiscoveryService: NetServiceDelegate {
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        
        guard let addresses = sender.addresses else { return }
        
        for addressData in addresses {
            
            var hostBuffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            
            let result = addressData.withUnsafeBytes { pointer -> Int32 in
                guard let sockaddrPtr = pointer.baseAddress?.assumingMemoryBound(to: sockaddr.self) else {
                    return -1
                }
                
                return getnameinfo(
                    sockaddrPtr,
                    socklen_t(addressData.count),
                    &hostBuffer,
                    socklen_t(hostBuffer.count),
                    nil,
                    0,
                    NI_NUMERICHOST
                )
            }
            
            if result == 0 {
                let ip = String(cString: hostBuffer)
                
                let device = AirPlayDevice(
                    identifier: sender.name,
                    name: sender.name,
                    ipAddress: ip,
                    isReachable: true
                )
                
                onDeviceFound?(device)
                return
            }
        }
    }
}
