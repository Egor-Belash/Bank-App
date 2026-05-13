//
//  OnBoardingRouter.swift
//  Bank App
//
//  Created by Egor on 13.05.2026.
//

import UIKit

final class OnBoardingRouter: OnBoardingRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let vc = OnBoardingViewController()
        let router = OnBoardingRouter()
        
        vc.router = router
        router.viewController = vc
        
        return vc
    }
    
    func openLogInViewController() {
        // Showing onboarding once
        UserDefaults.standard.set(true, forKey: "onboardingIsDone")
        
        // Go to the LogInVC
        let vc = LogInRouter.build()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window
        else { return }
    
        window.rootViewController = vc
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
