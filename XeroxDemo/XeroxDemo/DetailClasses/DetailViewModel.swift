//
//  DetailViewModel.swift
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

import Foundation

final class DetailViewModel {

    private let service = IPInfoService()

    func fetchIPDetails(completion: @escaping (IPInfo?) -> Void) {
        service.fetchInfo { info in
            completion(info)
        }
    }
}
