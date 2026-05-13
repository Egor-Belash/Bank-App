import UIKit

final class LogInRouter: LogInRouterProtocol {

    weak var viewController: UIViewController?

    static func build() -> UIViewController {
        let vc = LogInViewController()
        let presenter = LogInPresenter()
        let router = LogInRouter()

        vc.presenter = presenter
        presenter.view = vc
        presenter.router = router
        router.viewController = vc

        return vc
    }

    func goToMainTabBarScreen() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else
        { return }
        
        window.rootViewController = MainTabBarViewController()
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionFlipFromBottom,
            animations: nil,
            completion: nil
        )
    }

    func goToRegistrationScreen() {
        let vc = RegistrationRouter.build()
        let nav = UINavigationController(rootViewController: vc)
        viewController?.present(nav, animated: true)
    }

}
