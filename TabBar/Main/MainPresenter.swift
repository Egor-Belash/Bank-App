//
//  MainPresenter.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    
    init(view: MainViewProtocol? = nil) {
        self.view = view
    }
    
    func viewDidLoad() {
        getUserName()
        showNotificationRequest()
    }
    
    func exchangeRatesTapped() {
        router?.openExchangeRates()
    }
    
    func newsTapped() {
        router?.openNews()
    }
    
    // MARK: – Privates
    private func getUserName() {
        let userName = UserDefaults.standard.string(forKey: "name") ?? "User"
        view?.getUserName(name: userName)
    }
    
    private func showNotificationRequest() {
        NotificationService.shared.requestPermission { granted in
            if granted {
                UserDefaults.standard.set(true, forKey: "notifications")
                NotificationService.shared.scheduleNotification()
                print("✅ Разрешение на уведомления получено")
            } else {
                UserDefaults.standard.set(false, forKey: "notifications")
                print("❌ Пользователь отказался от получения уведомлений")
            }
        }
    }

}
