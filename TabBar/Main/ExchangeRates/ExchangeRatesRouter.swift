//
//  ExchangeRatesRounter.swift
//  Bank App
//
//  Created by Egor on 06.05.2026.
//

import UIKit

final class ExchangeRatesRouter: ExchangeRatesRouterProtocol {

    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = ExchangeRatesViewController()
        let presenter = ExchangeRatesPresenter()
        let router = ExchangeRatesRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
    func openExchangeRates() {
        let vc = Self.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
