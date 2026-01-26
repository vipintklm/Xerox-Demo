//
//  IPInfoService.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import Foundation
final class IPInfoService {

    func fetchInfo(completion: @escaping (IPInfo?) -> Void) {
        let ipURL = URL(string: "https://api.ipify.org?format=json")!

        NetworkClient.get(ipURL) { (result: Result<PublicIP, Error>) in
            guard case let .success(ip) = result else {
                completion(nil)
                return
            }

            let geoURL = URL(string: "https://ipinfo.io/\(ip.ip)/geo")!
            NetworkClient.get(geoURL) { (geoResult: Result<IPInfo, Error>) in
                completion(try? geoResult.get())
            }
        }
    }
}
