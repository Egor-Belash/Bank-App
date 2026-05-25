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

    func bankTapped() {
        router?.openBankLocation()
    }
    
    // MARK: – Privates
    private func getUserName() {
        let userName = UserDefaults.standard.string(forKey: "name") ?? String(localized: .user)
        guard !userName.isEmpty else {
            view?.getUserName(name: String(localized: .user))
            return
        }
        view?.getUserName(name: userName)
    }
    
    private func showNotificationRequest() {
        let didAsk = UserDefaults.standard.bool(forKey: "didAskNotificationsPermission")
        
        guard didAsk == false else { return }
        
        NotificationService.shared.requestPermission { granted in
            UserDefaults.standard.set(true, forKey: "didAskNotificationsPermission")
            
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
