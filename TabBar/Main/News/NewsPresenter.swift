//
//  NewsPresenter.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import Foundation

final class NewsPresenter: NewsPresenterProtocol {
    
    weak var view: NewsViewProtocol?
    private var news: [NewsModel] = []
    var router: NewsRouterProtocol?
    
    init(view: NewsViewProtocol? = nil) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchNews()
    }
    
    func reloadTapped() {
        self.view?.showLoading()
        fetchNews()
    }
    
    func newsTapped() {
        router?.openNews()
    }
    
    func didSelectNews(_ news: NewsModel) {
        router?.openDetailedNews(news)
    }
    
    // MARK: – Privates
    private func fetchNews() {
        NetworkService.shared.fetchNews { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self?.news = news
                    self?.view?.showNews(news)
                case .failure(let error):
                    self?.view?.showError("Failed to fetch data:\n\(error.localizedDescription)")
                }
            }
        }
    }
}
