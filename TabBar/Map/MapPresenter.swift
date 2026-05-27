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

    private var banks: [PlaceAnnotation] = []

    func viewDidLoad() {
        fetchBankLocation()
    }


    // MARK: – Privates
    private func fetchBankLocation() {
        NetworkService.shared.fetchBankLocation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bankLocations):
                    // ПОСМОТРЕТЬ КАК ПРИДУТ ДАННЫЕ, ТУТ НАДО БУДЕТ ИХ ЗАПИХНУТЬ В banks, точнее координаты в PlaceAnnotation
                    self?.banks = bankLocations
                    self?.view?.showBanks(banks)
                case .failure(let error):
                    
                }
            }
        }
    }
    
}
