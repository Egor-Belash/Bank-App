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
    private var banks: [PlaceAnnotation] = []
    
    // MARK: – Subviews
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.tintColor = .systemGray5
        mapView.isHidden = true
        return mapView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 25
        button.isHidden = true
        return button
    }()
    
    // MARK: – Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()

        activityIndicator.startAnimating()
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
        view.addSubview(label)
        view.addSubview(reloadButton)
        
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            reloadButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 100),
            reloadButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    // MARK: - Actions
    @objc private func reloadButtonTapped() {
        showLoading()
        presenter?.viewDidLoad()
    }
    
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
    func showLoading() {
        activityIndicator.startAnimating()
        reloadButton.isHidden = true
        label.isHidden = true
    }
    
    func showError(_ message: String) {
        activityIndicator.stopAnimating()
        reloadButton.isHidden = false
        label.isHidden = false
        label.text = message
    }
    
    func showBanks(_ coordinates: [(Double, Double)]) {
        
        banks.removeAll()
        
        for coordinate in coordinates {
            let annotation = PlaceAnnotation.init(
                coordinate: CLLocationCoordinate2D(
                    latitude: coordinate.0,
                    longitude: coordinate.1
                )
            )
            banks.append(annotation)
        }
        
        mapView.isHidden = false
        activityIndicator.stopAnimating()
        label.isHidden = true
        addAllAnnotations()
    }
}

// MARK: – MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
}
