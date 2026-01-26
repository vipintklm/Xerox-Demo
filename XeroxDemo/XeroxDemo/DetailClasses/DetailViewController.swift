//
//  DetailViewController.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//


import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        infoLabel.isHidden = true
        activityIndicator.startAnimating()
        viewModel = viewModel ?? DetailViewModel()
        fetchDetails()
    }
    
    private func fetchDetails() {
        viewModel.fetchIPDetails { [weak self] info in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                guard let info = info else {
                    self?.infoLabel.text = "Failed to load IP info"
                    self?.infoLabel.isHidden = false
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
        self.infoLabel.isHidden = false
    }
}
