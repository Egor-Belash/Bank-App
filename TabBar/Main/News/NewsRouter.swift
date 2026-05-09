//
//  NewsRouter.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import UIKit

final class NewsRouter: NewsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = NewsViewController()
        let presenter = NewsPresenter()
        let router = NewsRouter()
        
        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter
        
        return vc
    }
    
    func openNews() {
        let vc = Self.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetailedNews(_ news: NewsModel) {
        print("router called" )
        let vc = DetailedNewsViewController(news: news)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
