//
//  SettingsProtocols.swift
//  Bank App
//
//  Created by Egor on 09.05.2026.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    func loadThemeValue(_ value: Int)
    func setTextForNotification(_ text: String)
    func setSwitchIsOn(_ isOn: Bool)
    func showAlertToOpenSettings()
}

protocol SettingsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func nightModeSegmentTapped(_ segment: Int)
    func notificationSwitchTapped(_ isOn: Bool)
    func logoutButtonTapped()
    
}

protocol SettingsRouterProtocol: AnyObject {
    func moveToLoginVC()
}
