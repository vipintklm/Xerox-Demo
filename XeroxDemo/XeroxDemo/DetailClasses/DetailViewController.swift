//
//  DetailViewController.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//


import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        viewModel = viewModel ?? DetailViewModel()
        fetchDetails()
    }
    
    private func fetchDetails() {
        viewModel.fetchIPDetails { [weak self] info in
            DispatchQueue.main.async {
                guard let info = info else {
                    self?.infoLabel.text = "Failed to load IP info"
                    return
                }
                self?.updateUI(with: info)
            }
        }
    }
    
    private func updateUI(with info: IPInfo) {
        infoLabel.text = """
        City: \(info.city ?? "-")
        Region: \(info.region ?? "-")
        Country: \(info.country ?? "-")
        Org: \(info.org ?? "-")
        """
    }
}
