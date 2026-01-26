//
//  DeviceTableViewCell.swift
//  XeroxDemo
//
//  Created by vipin v on 25/01/26.
//

import UIKit

final class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusLabel.layer.cornerRadius = 6
        statusLabel.layer.masksToBounds = true
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        selectionStyle = .none
    }
    
    func configure(with device: AirPlayDevice) {
        nameLabel.text = device.name
        ipLabel.text = device.ipAddress
        
        if device.isReachable {
            statusLabel.text = "Reachable"
            statusLabel.textColor = .systemGreen
        } else {
            statusLabel.text = "Un-Reachable"
            statusLabel.textColor = .systemRed
        }
    }
}
