//
//  NewsProtocols.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import Foundation

protocol NewsViewProtocol: AnyObject {
    func showLoading()
    func showNews(_ news: [NewsModel])
    func showError(_ message: String)
}

protocol NewsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func reloadTapped()
    func didSelectNews(_ news: NewsModel)
}

protocol NewsRouterProtocol: AnyObject {
    func openNews()
    func openDetailedNews(_ news: NewsModel)
}
