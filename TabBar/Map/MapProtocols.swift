//
//  MapProtocols.swift
//  Bank App
//
//  Created by Egor on 25.05.2026.
//

import Foundation

protocol MapViewProtocol: AnyObject {
    func showBanks(_ banks: [PlaceAnnotation])
}

protocol MapPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol MapRouterProtocol: AnyObject {
    
}
