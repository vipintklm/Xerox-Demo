//
//  HomeViewController.swift
//  XeroxDemo
//
//  Created by vipin v on 23/01/26.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Discovered Devices"
        
        setupViewModel()
        bindViewModel()
        viewModel.loadSavedDevices()
        viewModel.startDiscovery()
    }
    
    
    private func setupViewModel() {
        viewModel = HomeViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.devices.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "DeviceCell",
            for: indexPath
        ) as? DeviceTableViewCell else {
            return UITableViewCell()
        }
        
        let device = viewModel.devices[indexPath.row]
        cell.configure(with: device)
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController"
        ) as? DetailViewController else {
            return
        }
        
        detailVC.viewModel = DetailViewModel()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
