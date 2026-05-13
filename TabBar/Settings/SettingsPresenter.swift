//
//  SettingsPresenter.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import Foundation

final class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol?
    
    init(view: SettingsViewProtocol? = nil) {
        self.view = view
    }
    
    func viewDidLoad() {
        loadThemeValue()
        loadNotificationStatus()
    }
    
    func nightModeSegmentTapped(_ segment: Int) {
        let selectedTheme = AppTheme(rawValue: segment) ?? .system
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: "theme")
        ThemeManager.applyTheme(selectedTheme)
    }
    
    func notificationSwitchTapped(_ isOn: Bool) {
        if isOn {
            NotificationService.shared.requestPermission { [weak self] granted in
                if granted {
                    self?.view?.setTextForNotification(String(localized: .settingsDisableNotificationLabel))
                    UserDefaults.standard.set(true, forKey: "notifications")
                    NotificationService.shared.scheduleNotification()
                } else {
                    self?.view?.setTextForNotification(String(localized: .settingsEnableNotificationLabel))
                    self?.view?.setSwitchIsOn(false)
                    UserDefaults.standard.set(false, forKey: "notifications")
                    
                    self?.view?.showAlertToOpenSettings()
                }
            }
        } else {
            view?.setTextForNotification(String(localized: .settingsEnableNotificationLabel))
            UserDefaults.standard.set(false, forKey: "notifications")
            NotificationService.shared.cancelNotifications()
        }
    }
    
    func logoutButtonTapped() {
        router?.moveToLoginVC()
    }
    
    // MARK: – Privates
    private func loadThemeValue() {
        let themeValue = UserDefaults.standard.integer(forKey: "theme")
        let theme = AppTheme(rawValue: themeValue) ?? .system
        
        view?.loadThemeValue(theme.rawValue)
    }
    
    private func loadNotificationStatus() {
        let value = UserDefaults.standard.bool(forKey: "notifications")
        view?.setSwitchIsOn(value)
        view?.setTextForNotification(value == true ? String(localized: .settingsDisableNotificationLabel) : String(localized: .settingsEnableNotificationLabel))
    }
}
