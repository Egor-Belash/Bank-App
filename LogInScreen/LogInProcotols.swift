import Foundation

protocol LogInViewProtocol: AnyObject {

    func showError(_ title: String, _ message: String)
}

protocol LogInPresenterProtocol: AnyObject {
    func loginButtonTapped(_ login: String, _ password: String)
    func registrationButtonTapped()
}

protocol LogInRouterProtocol: AnyObject {
    func goToMainTabBarScreen()
    func goToRegistrationScreen()
}