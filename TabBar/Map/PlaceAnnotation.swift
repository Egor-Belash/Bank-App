//
//  PlaceAnnotation.swift
//  Bank App
//
//  Created by Egor on 27.05.2026.
//

import UIKit
import MapKit
final class PlaceAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
