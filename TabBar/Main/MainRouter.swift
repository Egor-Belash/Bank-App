//
//  MainRouter.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import UIKit

final class MainRouter: MainRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
    func openExchangeRates() {
        let vc = ExchangeRatesRouter.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openNews() {
        let vc = NewsRouter.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
