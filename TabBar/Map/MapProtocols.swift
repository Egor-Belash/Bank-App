//
//  MapProtocols.swift
//  Bank App
//
//  Created by Egor on 25.05.2026.
//

import Foundation

protocol MapViewProtocol: AnyObject {
    func showBanks(_ coordinates: [(Double, Double, String)])
    func showError(_ message: String)
    func showLoading()
}

protocol MapPresenterProtocol: AnyObject {
    func viewDidLoad()
    func reloadButtonTapped()
}

protocol MapRouterProtocol: AnyObject {
    
}
