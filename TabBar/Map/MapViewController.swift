//
//  MapViewController.swift
//  Bank App
//
//  Created by Egor on 25.05.2026.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: – Properties
    var presenter: MapPresenterProtocol?
    
    // MARK: – Subviews
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        mapView.showsScale = true
        return mapView
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
        mapView.delegate = self
    }
    
    private func setupSubviews() {
        view.addSubview(mapView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
        ])
    }
    
}

// MARK: – MapViewProtocol
extension MapViewController: MapViewProtocol {
    
}

// MARK: – MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
}
