//
//  IPInfo.swift
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

import Foundation
struct PublicIP: Decodable {
    let ip: String
}

struct IPInfo: Decodable {
    let city: String?
    let region: String?
    let country: String?
    let org: String?
}
