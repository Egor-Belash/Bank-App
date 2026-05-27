//
//  MapPresenter.swift
//  Bank App
//
//  Created by Egor on 25.05.2026.
//

import Foundation

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var router: MapRouterProtocol?

    func viewDidLoad() {
        fetchBankLocation()
    }
    
    func reloadButtonTapped() {
        view?.showLoading()
    }

    // MARK: – Privates
    private func fetchBankLocation() {
        NetworkService.shared.fetchBankLocation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bankLocations):
                    let coordinates = self?.getData(bankLocations)
                    self?.view?.showBanks(coordinates ?? [])
                    
                case .failure(let error):
                    self?.view?.showError("Failed to fetch data:\n\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getData(_ data: [BranchData]) -> [(Double, Double)] {
        var result: [(Double, Double)] = []
        
        for branch in data {
            guard let geolocation = branch.postalAddress.geolocation,
                  let latitude = Double(geolocation.latitude),
                  let longitude = Double(geolocation.longitude)
            else { continue }
            
            result.append((latitude, longitude))
        }
        return result
    }
    
}
