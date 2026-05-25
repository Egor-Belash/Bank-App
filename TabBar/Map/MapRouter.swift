//
//  MapRouter.swift
//  Bank App
//
//  Created by Egor on 25.05.2026.
//

import UIKit

final class MapRouter: MapRouterProtocol {

    weak var viewController: UIViewController?

    static func build() -> UIViewController {
        let vc = MapViewController()
        let presenter = MapPresenter()
        let router = MapRouter()

        presenter.view = vc
        presenter.router = router
        vc.presenter = presenter
        router.viewController = vc

        return vc
    }

}
