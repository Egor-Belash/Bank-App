//
//  AppTheme.swift
//  Bank App
//
//  Created by Egor on 03.05.2026.
//

import UIKit

enum AppTheme: Int {
    case system = 0
    case light = 1
    case dark = 2
}

final class ThemeManager {
    
    static func applyTheme(_ theme: AppTheme) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        switch theme {
        case .system:
            window.overrideUserInterfaceStyle = .unspecified
        case .light:
            window.overrideUserInterfaceStyle = .light
        case .dark:
            window.overrideUserInterfaceStyle = .dark
        }
    }

}

