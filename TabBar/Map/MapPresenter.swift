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
                    self?.view?.showBanks(coordinates ?? [])        // переименовать coordinates
                    
                case .failure(let error):
                    self?.view?.showError("Failed to fetch data:\n\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getData(_ data: [BranchData]) -> [(Double, Double, String)] {
        var result: [(Double, Double, String)] = []
        
        for branch in data {
            guard let geolocation = branch.postalAddress.geolocation,
                  let latitude = Double(geolocation.latitude),
                  let longitude = Double(geolocation.longitude),
                  let streetName = branch.postalAddress.streetName,
                  let buildingNumber = branch.postalAddress.buildingNumber
            else { continue }
            
            let address = streetName + buildingNumber
            result.append((latitude, longitude, address))
        }
        return result
    }
    
}
