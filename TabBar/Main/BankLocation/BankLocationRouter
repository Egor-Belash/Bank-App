import UIKit

final class BankLocationRouter: BankLocationRouterProtocol {

    weak var viewController: UIViewController?

    static func build() -> UIViewController {
        let vc = BankLocationViewController()
        let presenter = BankLocationPresenter()
        let router = BankLocationRouter()

        presenter.view = vc
        presenter.router = router
        vc.presenter = presenter
        router.viewController = vc

        return vc
    }

}