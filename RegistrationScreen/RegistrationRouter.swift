import UIKit

final class RegistrationRouter: RegistrationRouterProtocol {

    weak var viewController: UIViewController?

    static func build() -> UIViewController {
        let vc = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()

        presenter.view = vc
        presenter.router = router
        router.viewController = vc
        vc.presenter = presenter

        return vc
    }

    func openRegistrationVC() {
        let vc = Self.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func closeRegistrationVC() {
        viewController?.dismiss(animated: true)
    }
}