//
//  DeviceRepository.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import Foundation
import CoreData

final class DeviceRepository {

    private let context = CoreDataStack.shared.context

    // MARK: - Save or Update Device


    func save(_ device: AirPlayDevice) {
        let request: NSFetchRequest<CDDevice> = CDDevice.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", device.identifier)

        let cdDevice = (try? context.fetch(request))?.first ?? CDDevice(context: context)

        cdDevice.identifier = device.identifier
        cdDevice.name = device.name
        cdDevice.ipAddress = device.ipAddress
        cdDevice.isReachable = device.isReachable

        try? context.save()
    }

    // MARK: - Fetch Stored Devices

    func fetchAll() -> [AirPlayDevice] {

        let request: NSFetchRequest<CDDevice> = CDDevice.fetchRequest()

        guard let results = try? context.fetch(request) else {
            return []
        }

        return results.map {
            AirPlayDevice(
                identifier: $0.identifier ?? "",
                name: $0.name ?? "",
                ipAddress: $0.ipAddress ?? "",
                isReachable: $0.isReachable
            )
        }
    }
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            CDDevice.fetchRequest()

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear devices: \(error)")
        }
    }
    // MARK: - Update Reachability

    func updateReachability(identifier: String, isReachable: Bool) {

        let request: NSFetchRequest<CDDevice> = CDDevice.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", identifier)

        guard let device = try? context.fetch(request).first else {
            return
        }

        device.isReachable = isReachable
        device.lastSeen = Date()
        CoreDataStack.shared.saveContext()
    }
}

