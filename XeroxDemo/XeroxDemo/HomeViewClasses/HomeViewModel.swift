//
//  HomeViewModel.swift
//  XeroxDemo
//
//  Created by vipin v on 24/01/26.
//

import Foundation

final class HomeViewModel {

    private let discoveryService = MDNSDiscoveryService()
    private let repository = DeviceRepository()

    private(set) var devices: [AirPlayDevice] = []
    var onUpdate: (() -> Void)?

    init() {
        discoveryService.onDeviceFound = { [weak self] device in
            DispatchQueue.main.async {
                self?.updateDevice(device)
            }
        }
    }

    func loadSavedDevices() {
        devices = repository.fetchAll()
        print("Core Data devices:", devices.count)
        onUpdate?()
    }


    func startDiscovery() {
        discoveryService.start()
    }

    private func updateDevice(_ device: AirPlayDevice) {

        repository.save(device)

        if let index = devices.firstIndex(where: {
            $0.identifier == device.identifier
        }) {
            devices[index] = device
        } else {
            devices.append(device)
        }

        onUpdate?()
    }


}
