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
    let title: String?
    let subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
