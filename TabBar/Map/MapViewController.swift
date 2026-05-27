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
    private var banks = [PlaceAnnotation] = []
    
    // MARK: – Subviews
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        mapView.showsScale = true
        return mapView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()

        presenter?.viewDidLoad()
    }
    
    // MARK: – Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
        mapView.delegate = self
    }
    
    private func setupSubviews() {
        view.addSubview(mapView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: - Actions
    private func addAllAnnotations() {
        // MKUserLocation — системная аннотация синей точки геолокации пользователя.
        // Фильтруем её, чтобы не удалить/не задублировать случайно.
        let existing = mapView.annotations.filter { !($0 is MKUserLocation) }
        mapView.removeAnnotations(existing)

        mapView.addAnnotations(banks)
        mapView.showAnnotations(banks, animated: true)
    }
    
}

// MARK: – MapViewProtocol
extension MapViewController: MapViewProtocol {
    func showBanks(_ banks: [PlaceAnnotation]) {
        addAllAnnotations()
    }
}

// MARK: – MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
}
